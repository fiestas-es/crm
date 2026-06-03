import { NextResponse } from "next/server";
import { createServiceClient, hasSupabaseEnv } from "@/lib/supabase/service";
import { calculateOpportunityScore } from "@/lib/scoring";
import { slugify } from "@/lib/utils";

function authorized(request: Request) {
  const secret = process.env.CRON_SECRET;
  if (!secret) return true;
  const auth = request.headers.get("authorization");
  return auth === `Bearer ${secret}`;
}

async function runTicketmasterImport() {
  const apiKey = process.env.TICKETMASTER_API_KEY;
  if (!apiKey || !hasSupabaseEnv()) return { imported: 0, reason: "Sin TICKETMASTER_API_KEY o Supabase" };

  const supabase = createServiceClient();
  const url = new URL("https://app.ticketmaster.com/discovery/v2/events.json");
  url.searchParams.set("apikey", apiKey);
  url.searchParams.set("countryCode", "ES");
  url.searchParams.set("classificationName", "music");
  url.searchParams.set("keyword", "festival");
  url.searchParams.set("size", "50");
  url.searchParams.set("sort", "date,asc");

  const response = await fetch(url.toString(), { next: { revalidate: 0 } });
  if (!response.ok) return { imported: 0, reason: `Ticketmaster ${response.status}` };
  const json = await response.json();
  const events = json?._embedded?.events || [];
  let imported = 0;

  for (const event of events) {
    const name = event.name as string;
    if (!name) continue;
    const venue = event._embedded?.venues?.[0];
    const city = venue?.city?.name || null;
    const province = venue?.state?.name || null;
    const lat = venue?.location?.latitude ? Number(venue.location.latitude) : null;
    const lng = venue?.location?.longitude ? Number(venue.location.longitude) : null;
    const start = event.dates?.start?.localDate || null;
    const slug = slugify(name);

    const { data: festival } = await supabase
      .from("festivals")
      .upsert({
        name,
        slug,
        official_website: event.url || null,
        status: "active"
      }, { onConflict: "slug" })
      .select("*")
      .single();

    if (!festival) continue;

    const score = calculateOpportunityScore({
      start_date: start,
      official_website: event.url,
      sales_stage: "Detectado en ticketing"
    });

    const { data: edition } = await supabase
      .from("festival_editions")
      .insert({
        festival_id: festival.id,
        year: start ? new Date(start).getFullYear() : new Date().getFullYear(),
        start_date: start,
        venue_name: venue?.name || null,
        city,
        province,
        latitude: lat,
        longitude: lng,
        sales_stage: "Detectado en ticketing",
        lifecycle_stage: "Detectado",
        ticket_status: "Revisar",
        opportunity_score: score,
        data_confidence: "media",
        last_checked_at: new Date().toISOString()
      })
      .select("*")
      .single();

    await supabase.from("sources").insert({
      festival_id: festival.id,
      edition_id: edition?.id || null,
      source_type: "ticketmaster",
      url: event.url || null,
      extracted_data: event,
      confidence: "media"
    });

    await supabase.from("radar_alerts").insert({
      festival_id: festival.id,
      title: "Festival detectado en Ticketmaster",
      description: `${name} requiere revisión manual y enriquecimiento de contactos.`,
      severity: score >= 70 ? "high" : "medium",
      status: "open"
    });
    imported++;
  }

  return { imported };
}

export async function GET(request: Request) {
  if (!authorized(request)) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const result = await runTicketmasterImport();
  return NextResponse.json({ ok: true, result });
}

export async function POST(request: Request) {
  // Permitimos POST desde el botón interno aunque no tenga Authorization, porque la app ya está detrás del login.
  const result = await runTicketmasterImport();
  return NextResponse.json({ ok: true, result });
}
