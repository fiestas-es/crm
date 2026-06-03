import { NextResponse } from "next/server";
import { getSql } from "@/lib/postgres";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";
export const revalidate = 0;

function authorized(request: Request) {
  const secret = process.env.CRON_SECRET;
  if (!secret) return true;
  const auth = request.headers.get("authorization");
  const url = new URL(request.url);
  const querySecret = url.searchParams.get("secret");
  const isVercelCron = request.headers.get("user-agent")?.includes("vercel-cron");
  return auth === `Bearer ${secret}` || querySecret === secret || Boolean(isVercelCron);
}

function slugify(value: string) {
  return value
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "")
    .slice(0, 90);
}

function looksLikeFestival(name: string) {
  return /festival|fest|sound|live|weekend|music|música|musica|beach|sonora|fib|bbk|sonar|sónar|arenal|cruilla|cruïlla|mad cool|primavera|medusa|dreambeach|zevra|aquasella|riverland|boombastic/i.test(name);
}

function scoreFromEvent(event: any) {
  let score = 42;
  const start = event?.dates?.start?.localDate;
  const url = event?.url;
  const price = event?.priceRanges?.[0];

  if (url) score += 8;
  if (price?.min) score += 8;
  if (price?.max && price.max > 80) score += 4;
  if (start) {
    const days = Math.round((new Date(start).getTime() - Date.now()) / 86_400_000);
    if (days >= 30 && days <= 180) score += 24;
    else if (days > 180 && days <= 365) score += 14;
    else if (days >= 0) score += 6;
  }
  if (/mad cool|primavera|sonar|sónar|bbk|arenal|fib|medusa|dreambeach|cruilla|cruïlla|riverland|aquasella|zevra|resurrection|viña/i.test(event?.name || "")) score += 12;

  return Math.min(95, score);
}

async function upsertFestival(sql: ReturnType<typeof getSql>, payload: any) {
  const slug = payload.slug;
  const existing = await sql<{ id: string }[]>`
    select id from public.festivals where slug = ${slug} limit 1
  `;

  if (existing[0]) {
    await sql`
      update public.festivals
      set
        name = coalesce(${payload.name}, name),
        official_website = coalesce(${payload.official_website}, official_website),
        status = 'active',
        status = 'active'
      where id = ${existing[0].id}
    `;
    return existing[0].id;
  }

  const inserted = await sql<{ id: string }[]>`
    insert into public.festivals (name, slug, official_website, status)
    values (${payload.name}, ${slug}, ${payload.official_website}, 'active')
    returning id
  `;

  return inserted[0].id;
}

async function upsertEdition(sql: ReturnType<typeof getSql>, festivalId: string, payload: any) {
  const existing = await sql<{ id: string }[]>`
    select id
    from public.festival_editions
    where festival_id = ${festivalId} and year = ${payload.year}
    order by start_date desc nulls last
    limit 1
  `;

  if (existing[0]) {
    const updated = await sql<{ id: string }[]>`
      update public.festival_editions
      set
        start_date = coalesce(${payload.start_date}, start_date),
        end_date = coalesce(${payload.end_date}, end_date),
        venue_name = coalesce(${payload.venue_name}, venue_name),
        city = coalesce(${payload.city}, city),
        province = coalesce(${payload.province}, province),
        region = coalesce(${payload.region}, region),
        latitude = coalesce(${payload.latitude}, latitude),
        longitude = coalesce(${payload.longitude}, longitude),
        sales_stage = coalesce(${payload.sales_stage}, sales_stage),
        lifecycle_stage = coalesce(${payload.lifecycle_stage}, lifecycle_stage),
        commercial_stage = coalesce(commercial_stage, 'nuevo'),
        ticket_status = coalesce(${payload.ticket_status}, ticket_status),
        ticket_min_price = coalesce(${payload.ticket_min_price}, ticket_min_price),
        ticket_max_price = coalesce(${payload.ticket_max_price}, ticket_max_price),
        ticket_url = coalesce(${payload.ticket_url}, ticket_url),
        opportunity_score = greatest(coalesce(opportunity_score, 0), ${payload.opportunity_score}),
        data_confidence = coalesce(data_confidence, ${payload.data_confidence}),
        last_checked_at = now()
      where id = ${existing[0].id}
      returning id
    `;
    return updated[0].id;
  }

  const inserted = await sql<{ id: string }[]>`
    insert into public.festival_editions (
      festival_id, year, start_date, end_date, venue_name, city, province, region,
      latitude, longitude, sales_stage, lifecycle_stage, commercial_stage, ticket_status,
      ticket_min_price, ticket_max_price, ticket_url, opportunity_score, data_confidence, last_checked_at
    ) values (
      ${festivalId}, ${payload.year}, ${payload.start_date}, ${payload.end_date}, ${payload.venue_name},
      ${payload.city}, ${payload.province}, ${payload.region}, ${payload.latitude}, ${payload.longitude},
      ${payload.sales_stage}, ${payload.lifecycle_stage}, 'nuevo', ${payload.ticket_status},
      ${payload.ticket_min_price}, ${payload.ticket_max_price}, ${payload.ticket_url},
      ${payload.opportunity_score}, ${payload.data_confidence}, now()
    )
    returning id
  `;

  return inserted[0].id;
}

async function createAlert(sql: ReturnType<typeof getSql>, festivalId: string, title: string, description: string, severity: string) {
  const existing = await sql<{ id: string }[]>`
    select id
    from public.radar_alerts
    where festival_id = ${festivalId} and title = ${title} and status = 'open'
    limit 1
  `;

  if (existing[0]) return false;

  await sql`
    insert into public.radar_alerts (festival_id, title, description, severity, status)
    values (${festivalId}, ${title}, ${description}, ${severity}, 'open')
  `;
  return true;
}

async function runTicketmasterImport() {
  const apiKey = process.env.TICKETMASTER_API_KEY;
  const sql = getSql();
  const keywords = ["festival", "fest", "sound", "live", "music", "beach", "weekend"];

  let scanned = 0;
  let imported = 0;
  let updated = 0;
  let alerts = 0;
  const warnings: string[] = [];

  if (!apiKey) {
    warnings.push("Sin TICKETMASTER_API_KEY: el radar solo deja constancia del run, pero no consulta Ticketmaster.");
  } else {
    for (const keyword of keywords) {
      const url = new URL("https://app.ticketmaster.com/discovery/v2/events.json");
      url.searchParams.set("apikey", apiKey);
      url.searchParams.set("countryCode", "ES");
      url.searchParams.set("classificationName", "music");
      url.searchParams.set("keyword", keyword);
      url.searchParams.set("size", "200");
      url.searchParams.set("sort", "date,asc");

      const response = await fetch(url.toString(), { cache: "no-store" });
      if (!response.ok) {
        warnings.push(`Ticketmaster ${keyword}: ${response.status}`);
        continue;
      }

      const json = await response.json();
      const events = json?._embedded?.events || [];
      scanned += events.length;

      for (const event of events) {
        const name = String(event?.name || "").trim();
        if (!name || !looksLikeFestival(name)) continue;

        const venue = event?._embedded?.venues?.[0];
        const start = event?.dates?.start?.localDate || null;
        const end = event?.dates?.end?.localDate || null;
        const year = start ? new Date(start).getFullYear() : new Date().getFullYear();
        const price = event?.priceRanges?.[0];
        const slug = slugify(name);
        const score = scoreFromEvent(event);

        const festivalId = await upsertFestival(sql, {
          name,
          slug,
          official_website: event?.url || null
        });

        const editionId = await upsertEdition(sql, festivalId, {
          year,
          start_date: start,
          end_date: end,
          venue_name: venue?.name || null,
          city: venue?.city?.name || null,
          province: venue?.state?.name || null,
          region: venue?.state?.name || null,
          latitude: venue?.location?.latitude ? Number(venue.location.latitude) : null,
          longitude: venue?.location?.longitude ? Number(venue.location.longitude) : null,
          sales_stage: "Detectado en ticketing",
          lifecycle_stage: "Detectado",
          ticket_status: event?.url ? "Disponible/Revisar" : "Revisar",
          ticket_min_price: price?.min ? Number(price.min) : null,
          ticket_max_price: price?.max ? Number(price.max) : null,
          ticket_url: event?.url || null,
          opportunity_score: score,
          data_confidence: "media"
        });

        await sql`
          insert into public.sources (festival_id, edition_id, source_type, url, extracted_data, confidence)
          values (${festivalId}, ${editionId}, 'ticketmaster', ${event?.url || null}, ${sql.json(event)}, 'media')
        `;

        const created = await createAlert(
          sql,
          festivalId,
          "Festival detectado o actualizado en Ticketmaster",
          `${name} requiere revisión: asistencia estimada, tramo real y responsables de marketing/patrocinios.`,
          score >= 75 ? "high" : "medium"
        );

        if (created) {
          imported++;
          alerts++;
        } else {
          updated++;
        }
      }
    }
  }

  try {
    await sql`
      insert into public.radar_runs (source, status, imported_count, updated_count, alert_count, raw_result)
      values ('ticketmaster', 'done', ${imported}, ${updated}, ${alerts}, ${sql.json({ scanned, warnings })})
    `;
  } catch (error) {
    warnings.push("No se pudo guardar radar_runs. Ejecuta supabase/v7_operational_upgrade.sql.");
  }

  return { scanned, imported, updated, alerts, warnings };
}

export async function GET(request: Request) {
  if (!authorized(request)) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const result = await runTicketmasterImport();
  return NextResponse.json({ ok: true, result });
}

export async function POST(request: Request) {
  if (!authorized(request)) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const result = await runTicketmasterImport();
  return NextResponse.json({ ok: true, result });
}
