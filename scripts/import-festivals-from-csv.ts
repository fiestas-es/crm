import fs from "node:fs";
import { parse } from "csv-parse/sync";
import { createClient } from "@supabase/supabase-js";

function slugify(input: string) {
  return input.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)+/g, "");
}

function score(row: any) {
  let value = 20;
  const attendance = Number(row.expected_attendance || row.avg_attendance || 0);
  if (attendance > 80000) value += 30;
  else if (attendance > 40000) value += 22;
  else if (attendance > 15000) value += 12;
  const stage = String(row.sales_stage || "").toLowerCase();
  if (stage.includes("tramo") || stage.includes("venta")) value += 25;
  if (row.start_date) value += 10;
  return Math.min(100, value);
}

async function main() {
  const file = process.argv[2];
  if (!file) throw new Error("Uso: npm run import:csv -- data/import_template.csv");

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key) throw new Error("Faltan NEXT_PUBLIC_SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY");

  const supabase = createClient(url, key, { auth: { persistSession: false } });
  const rows = parse(fs.readFileSync(file), { columns: true, skip_empty_lines: true, trim: true });

  for (const row of rows) {
    const name = row.name;
    if (!name) continue;
    const { data: festival, error: festivalError } = await supabase
      .from("festivals")
      .upsert({
        name,
        slug: slugify(name),
        official_website: row.official_website || null,
        instagram_url: row.instagram_url || null,
        ticket_url: row.ticket_url || null,
        main_genres: row.main_genres ? String(row.main_genres).split("|") : null,
        status: "active"
      }, { onConflict: "slug" })
      .select("*")
      .single();

    if (festivalError) throw festivalError;

    await supabase.from("festival_editions").insert({
      festival_id: festival.id,
      year: Number(row.year || new Date().getFullYear()),
      start_date: row.start_date || null,
      end_date: row.end_date || null,
      venue_name: row.venue_name || null,
      city: row.city || null,
      province: row.province || null,
      region: row.region || null,
      avg_attendance: row.avg_attendance ? Number(row.avg_attendance) : null,
      expected_attendance: row.expected_attendance ? Number(row.expected_attendance) : null,
      sales_stage: row.sales_stage || "Detectado",
      lifecycle_stage: row.lifecycle_stage || row.sales_stage || "Detectado",
      ticket_status: row.ticket_status || "Pendiente",
      opportunity_score: score(row),
      data_confidence: row.data_confidence || "baja",
      last_checked_at: new Date().toISOString()
    });
  }

  console.log(`Importados ${rows.length} registros`);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
