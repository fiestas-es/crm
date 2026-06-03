import { NextResponse } from "next/server";
import { createServiceClient, hasSupabaseEnv } from "@/lib/supabase/service";
import { calculateOpportunityScore } from "@/lib/scoring";
import { slugify } from "@/lib/utils";

function authorized(request: Request) {
  const secret = process.env.CRON_SECRET;
  if (!secret) return true;
  const auth = request.headers.get("authorization");
  const isVercelCron = request.headers.get("user-agent")?.includes("vercel-cron");
  return auth === `Bearer ${secret}` || Boolean(isVercelCron);
}

async function upsertEdition(supabase: any, festivalId: string, payload: any) {
  const { data: existing } = await supabase
    .from("festival_editions")
    .select("id")
    .eq("festival_id", festivalId)
    .eq("year", payload.year)
    .maybeSingle();

  if (existing?.id) {
    const { data } = await supabase
      .from("festival_editions")
      .update(payload)
      .eq("id", existing.id)
      .select("*")
      .single();
    return data;
  }

  const { data } = await supabase
    .from("festival_editions")
    .insert({ festival_id: festivalId, ...payload })
    .select("*")
    .single();
  return data;
}

async function runTicketmasterImport() {
  const apiKey = process.env.TICKETMASTER_API_KEY;
  if (!apiKey || !hasSupabaseEnv()) {
    return {
      imported: 0,
      updated: 0,
      reason: "Sin TICKETMASTER_API_KEY o Supabase. Añade TICKETMASTER_API_KEY en Vercel y redeploy."
    };
  }

  const supabase = createServiceClient();
  const keywords = ["festival", "fest", "live", "sound"];
  let imported = 0;
  let updated = 0;

  for (const keyword of keywords) {
    const url = new URL("https://app.ticketmaster.com/discovery/v2/events.json");
    url.searchParams.set("apikey", apiKey);
    url.searchParams.set("countryCode", "ES");
    url.searchParams.set("classificationName", "music");
    url.searchParams.set("keyword", keyword);
    url.searchParams.set("size", "100");
    url.searchParams.set("sort", "date,asc");

    const response = await fetch(url.toString(), { next: { revalidate: 0 } });
    if (!response.ok) continue;
    const json = await response.json();
    const events = json?._embedded?.events || [];

    for (const event of events) {
      const name = event.name as string;
      if (!name) continue;
      const looksLikeFestival = /festival|fest|sound|live|weekend|música|musica/i.test(name);
      if (!looksLikeFestival) continue;

      const venue = event._embedded?.venues?.[0];
      const city = venue?.city?.name || null;
      const province = venue?.state?.name || null;
      const lat = venue?.location?.latitude ? Number(venue.location.latitude) : null;
      const lng = venue?.location?.longitude ? Number(venue.location.longitude) : null;
      const start = event.dates?.start?.localDate || null;
      const year = start ? new Date(start).getFullYear() : new Date().getFullYear();
      const slug = slugify(name);

      const { data: festival } = await supabase
        .from("festivals")
        .upsert({ name, slug, official_website: event.url || null, status: "active" }, { onConflict: "slug" })
        .select("*")
        .single();

      if (!festival) continue;

      const score = calculateOpportunityScore({
        start_date: start,
        official_website: event.url,
        sales_stage: "Detectado en ticketing"
      });

      const editionPayload = {
        year,
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
      };

      const edition = await upsertEdition(supabase, festival.id, editionPayload);

      await supabase.from("sources").insert({
        festival_id: festival.id,
        edition_id: edition?.id || null,
        source_type: "ticketmaster",
        url: event.url || null,
        extracted_data: event,
        confidence: "media"
      });

      const { data: existingAlert } = await supabase
        .from("radar_alerts")
        .select("id")
        .eq("festival_id", festival.id)
        .eq("title", "Festival detectado en Ticketmaster")
        .eq("status", "open")
        .maybeSingle();

      if (!existingAlert) {
        await supabase.from("radar_alerts").insert({
          festival_id: festival.id,
          title: "Festival detectado en Ticketmaster",
          description: `${name} requiere revisión manual: asistencia estimada, tramo real y responsables de marketing/patrocinios.`,
          severity: score >= 70 ? "high" : "medium",
          status: "open"
        });
        imported++;
      } else {
        updated++;
      }
    }
  }

  return { imported, updated };
}

export async function GET(request: Request) {
  if (!authorized(request)) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const result = await runTicketmasterImport();
  return NextResponse.json({ ok: true, result });
}

export async function POST() {
  const result = await runTicketmasterImport();
  return NextResponse.json({ ok: true, result });
}
