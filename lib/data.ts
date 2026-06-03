import { createServiceClient, hasSupabaseEnv } from "./supabase/service";
import { mockAlerts, mockContacts, mockFestivals, mockProposals } from "./mock-data";
import type { Contact, FestivalOverview, Proposal, RadarAlert } from "./types";

export async function getFestivals(): Promise<FestivalOverview[]> {
  if (!hasSupabaseEnv()) return mockFestivals;
  const supabase = createServiceClient();
  const { data, error } = await supabase
    .from("festival_overview")
    .select("*")
    .order("opportunity_score", { ascending: false })
    .limit(500);

  if (error) {
    console.error(error);
    return mockFestivals;
  }
  return data || [];
}

export async function getFestival(id: string) {
  const festivals = await getFestivals();
  const festival = festivals.find((item) => item.festival_id === id || item.slug === id) || festivals[0];
  return festival;
}

export async function getContacts(festivalId?: string): Promise<Contact[]> {
  if (!hasSupabaseEnv()) return mockContacts;
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
    return (data || []).map((row: any) => row.contacts).filter(Boolean);
  }

  const { data, error } = await supabase.from("contacts").select("*").order("updated_at", { ascending: false }).limit(500);
  if (error) {
    console.error(error);
    return mockContacts;
  }
  return data || [];
}

export async function getRadarAlerts(): Promise<RadarAlert[]> {
  if (!hasSupabaseEnv()) return mockAlerts;
  const supabase = createServiceClient();
  const { data, error } = await supabase
    .from("radar_alerts_with_festival")
    .select("*")
    .eq("status", "open")
    .order("created_at", { ascending: false })
    .limit(80);
  if (error) {
    console.error(error);
    return mockAlerts;
  }
  return data || [];
}

export async function getProposals(): Promise<Proposal[]> {
  if (!hasSupabaseEnv()) return mockProposals;
  const supabase = createServiceClient();
  const { data, error } = await supabase
    .from("proposals_with_festival")
    .select("*")
    .order("created_at", { ascending: false })
    .limit(120);
  if (error) {
    console.error(error);
    return mockProposals;
  }
  return data || [];
}

export async function getDashboardData() {
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
