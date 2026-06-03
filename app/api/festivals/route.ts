import { NextResponse } from "next/server";
import { createServiceClient, hasSupabaseEnv } from "@/lib/supabase/service";
import { calculateOpportunityScore } from "@/lib/scoring";
import { slugify } from "@/lib/utils";

export async function POST(request: Request) {
  if (!hasSupabaseEnv()) {
    return NextResponse.json({ error: "Configura Supabase para guardar datos reales. Ahora estás en modo demo." }, { status: 400 });
  }

  const body = await request.json();
  const name = String(body.name || "").trim();
  if (!name) return NextResponse.json({ error: "Nombre requerido" }, { status: 400 });

  const supabase = createServiceClient();
  const slug = slugify(name);
  const genres = String(body.main_genres || "").split(",").map((x) => x.trim()).filter(Boolean);

  const { data: festival, error: festivalError } = await supabase
    .from("festivals")
    .upsert({
      name,
      slug,
      official_website: body.official_website || null,
      instagram_url: body.instagram_url || null,
      main_genres: genres.length ? genres : null,
      status: "active"
    }, { onConflict: "slug" })
    .select("*")
    .single();

  if (festivalError) return NextResponse.json({ error: festivalError.message }, { status: 500 });

  const editionPayload = {
    festival_id: festival.id,
    year: body.start_date ? new Date(body.start_date).getFullYear() : new Date().getFullYear(),
    start_date: body.start_date || null,
    end_date: body.end_date || null,
    city: body.city || null,
    province: body.province || null,
    region: body.region || null,
    expected_attendance: body.expected_attendance ? Number(body.expected_attendance) : null,
    sales_stage: body.sales_stage || "Detectado",
    lifecycle_stage: body.sales_stage || "Detectado",
    ticket_status: "Pendiente de validar",
    opportunity_score: calculateOpportunityScore({
      expected_attendance: body.expected_attendance ? Number(body.expected_attendance) : null,
      sales_stage: body.sales_stage,
      start_date: body.start_date,
      instagram_url: body.instagram_url,
      official_website: body.official_website
    }),
    data_confidence: "baja",
    last_checked_at: new Date().toISOString()
  };

  const { data: edition, error: editionError } = await supabase
    .from("festival_editions")
    .insert(editionPayload)
    .select("*")
    .single();

  if (editionError) return NextResponse.json({ error: editionError.message }, { status: 500 });

  await supabase.from("sources").insert({
    festival_id: festival.id,
    edition_id: edition.id,
    source_type: "manual",
    extracted_data: body,
    confidence: "baja"
  });

  return NextResponse.json({ festival, edition });
}
