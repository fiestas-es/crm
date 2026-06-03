import { unstable_noStore as noStore } from "next/cache";
import { createServiceClient, hasSupabaseEnv } from "./supabase/service";
import { getSql, hasPostgresEnv } from "./postgres";
import { mockAlerts, mockContacts, mockFestivals, mockProposals } from "./mock-data";
import type { Contact, FestivalOverview, Proposal, RadarAlert } from "./types";

async function getFestivalsFromPostgres(): Promise<FestivalOverview[]> {
  const sql = getSql();

  const rows = await sql<FestivalOverview[]>`
    select *
    from public.festival_overview
    order by opportunity_score desc nulls last, expected_attendance desc nulls last, name asc
    limit 700
  `;

  return rows;
}

async function getContactsFromPostgres(festivalId?: string): Promise<Contact[]> {
  const sql = getSql();

  if (festivalId) {
    return await sql<Contact[]>`
      select
        c.*,
        fc.responsibility,
        fc.priority,
        fc.relationship_status,
        fc.owner_name
      from public.festival_contacts fc
      join public.contacts c on c.id = fc.contact_id
      where fc.festival_id = ${festivalId}
      order by
        case when fc.priority = 'alta' then 1 when fc.priority = 'media' then 2 else 3 end,
        c.updated_at desc nulls last
      limit 200
    `;
  }

  return await sql<Contact[]>`
    select *
    from public.contacts
    order by updated_at desc nulls last
    limit 700
  `;
}

async function getRadarAlertsFromPostgres(): Promise<RadarAlert[]> {
  const sql = getSql();

  return await sql<RadarAlert[]>`
    select *
    from public.radar_alerts_with_festival
    where status = 'open'
    order by created_at desc nulls last
    limit 120
  `;
}

async function getProposalsFromPostgres(): Promise<Proposal[]> {
  const sql = getSql();

  return await sql<Proposal[]>`
    select *
    from public.proposals_with_festival
    order by created_at desc nulls last
    limit 180
  `;
}

export async function getFestivals(): Promise<FestivalOverview[]> {
  noStore();

  if (hasPostgresEnv()) {
    try {
      return await getFestivalsFromPostgres();
    } catch (error) {
      console.error("Postgres getFestivals error:", error);
    }
  }

  if (!hasSupabaseEnv()) return mockFestivals;

  try {
    const supabase = createServiceClient();

    const { data, error } = await supabase
      .from("festival_overview")
      .select("*")
      .order("opportunity_score", { ascending: false })
      .limit(700);

    if (error) {
      console.error(error);
      return mockFestivals;
    }

    return data || [];
  } catch (error) {
    console.error("Supabase getFestivals fetch failed:", error);
    return mockFestivals;
  }
}

export async function getFestival(id: string) {
  noStore();

  if (hasPostgresEnv()) {
    try {
      const sql = getSql();
      const rows = await sql<FestivalOverview[]>`
        select *
        from public.festival_overview
        where festival_id::text = ${id} or edition_id::text = ${id} or slug = ${id}
        order by opportunity_score desc nulls last
        limit 1
      `;
      if (rows[0]) return rows[0];
    } catch (error) {
      console.error("Postgres getFestival error:", error);
    }
  }

  const festivals = await getFestivals();
  return (
    festivals.find((item) => item.festival_id === id || item.edition_id === id || item.slug === id) ||
    festivals[0]
  );
}

export async function getContacts(festivalId?: string): Promise<Contact[]> {
  noStore();

  if (hasPostgresEnv()) {
    try {
      return await getContactsFromPostgres(festivalId);
    } catch (error) {
      console.error("Postgres getContacts error:", error);
    }
  }

  if (!hasSupabaseEnv()) return mockContacts;

  try {
    const supabase = createServiceClient();

    if (festivalId) {
      const { data, error } = await supabase
        .from("festival_contacts")
        .select("contacts(*)")
        .eq("festival_id", festivalId);

      if (error) {
        console.error(error);
        return [];
      }

      return (data || [])
        .map((row: any) => ({
          ...(row.contacts || {}),
          responsibility: row.responsibility || row.contacts?.role || null,
          priority: row.priority || null,
          relationship_status: row.relationship_status || null,
          owner_name: row.owner_name || null
        }))
        .filter((contact: any) => contact.id);
    }

    const { data, error } = await supabase
      .from("contacts")
      .select("*")
      .order("updated_at", { ascending: false })
      .limit(700);

    if (error) {
      console.error(error);
      return mockContacts;
    }

    return data || [];
  } catch (error) {
    console.error("Supabase getContacts fetch failed:", error);
    return mockContacts;
  }
}

export async function getRadarAlerts(): Promise<RadarAlert[]> {
  noStore();

  if (hasPostgresEnv()) {
    try {
      return await getRadarAlertsFromPostgres();
    } catch (error) {
      console.error("Postgres getRadarAlerts error:", error);
    }
  }

  if (!hasSupabaseEnv()) return mockAlerts;

  try {
    const supabase = createServiceClient();

    const { data, error } = await supabase
      .from("radar_alerts_with_festival")
      .select("*")
      .eq("status", "open")
      .order("created_at", { ascending: false })
      .limit(120);

    if (error) {
      console.error(error);
      return mockAlerts;
    }

    return data || [];
  } catch (error) {
    console.error("Supabase getRadarAlerts fetch failed:", error);
    return mockAlerts;
  }
}

export async function getProposals(): Promise<Proposal[]> {
  noStore();

  if (hasPostgresEnv()) {
    try {
      return await getProposalsFromPostgres();
    } catch (error) {
      console.error("Postgres getProposals error:", error);
    }
  }

  if (!hasSupabaseEnv()) return mockProposals;

  try {
    const supabase = createServiceClient();

    const { data, error } = await supabase
      .from("proposals_with_festival")
      .select("*")
      .order("created_at", { ascending: false })
      .limit(180);

    if (error) {
      console.error(error);
      return mockProposals;
    }

    return data || [];
  } catch (error) {
    console.error("Supabase getProposals fetch failed:", error);
    return mockProposals;
  }
}

export async function getDashboardData() {
  noStore();

  const [festivals, contacts, alerts, proposals] = await Promise.all([
    getFestivals(),
    getContacts(),
    getRadarAlerts(),
    getProposals()
  ]);

  return {
    festivals,
    contacts,
    alerts,
    proposals,
    stats: {
      totalFestivals: festivals.length,
      hot: festivals.filter((f) => (f.opportunity_score || 0) >= 80).length,
      withContacts: contacts.length,
      alerts: alerts.length,
      proposalsDraft: proposals.filter((p) => p.status === "draft").length
    }
  };
}
