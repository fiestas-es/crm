export type FestivalOverview = {
  festival_id: string;
  edition_id?: string | null;
  name: string;
  slug?: string | null;
  official_website?: string | null;
  instagram_url?: string | null;
  main_genres?: string[] | null;
  year?: number | null;
  start_date?: string | null;
  end_date?: string | null;
  venue_name?: string | null;
  city?: string | null;
  province?: string | null;
  region?: string | null;
  latitude?: number | null;
  longitude?: number | null;
  avg_attendance?: number | null;
  expected_attendance?: number | null;
  sales_stage?: string | null;
  lifecycle_stage?: string | null;
  ticket_status?: string | null;
  opportunity_score?: number | null;
  last_checked_at?: string | null;
  data_confidence?: string | null;
};

export type Contact = {
  id: string;
  name: string;
  role?: string | null;
  company?: string | null;
  email?: string | null;
  phone?: string | null;
  instagram?: string | null;
  linkedin?: string | null;
  source?: string | null;
  legal_basis?: string | null;
  do_not_contact?: boolean | null;
  notes?: string | null;
};

export type RadarAlert = {
  id: string;
  festival_id?: string | null;
  title: string;
  description?: string | null;
  severity: "low" | "medium" | "high" | string;
  status: "open" | "done" | "ignored" | string;
  created_at?: string | null;
  festival_name?: string | null;
};

export type Proposal = {
  id: string;
  festival_id?: string | null;
  contact_id?: string | null;
  channel: string;
  objective?: string | null;
  subject?: string | null;
  body: string;
  status: string;
  created_at?: string | null;
  festival_name?: string | null;
};

export type Interaction = {
  id: string;
  festival_id?: string | null;
  contact_id?: string | null;
  channel: string;
  direction: string;
  message?: string | null;
  outcome?: string | null;
  next_action_at?: string | null;
  created_at?: string | null;
};
