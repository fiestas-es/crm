create extension if not exists pgcrypto;

create table if not exists public.festivals (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique not null,
  official_website text,
  instagram_url text,
  tiktok_url text,
  facebook_url text,
  ticket_url text,
  promoter text,
  main_genres text[],
  status text not null default 'active',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.festival_editions (
  id uuid primary key default gen_random_uuid(),
  festival_id uuid not null references public.festivals(id) on delete cascade,
  year int not null,
  start_date date,
  end_date date,
  venue_name text,
  address text,
  city text,
  province text,
  region text,
  latitude numeric,
  longitude numeric,
  avg_attendance int,
  expected_attendance int,
  attendance_source_url text,
  sales_stage text default 'Detectado',
  lifecycle_stage text default 'Detectado',
  ticket_status text default 'Pendiente',
  opportunity_score int not null default 0 check (opportunity_score between 0 and 100),
  data_confidence text default 'baja' check (data_confidence in ('alta','media','baja')),
  last_checked_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.contacts (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  role text,
  company text,
  email text,
  phone text,
  whatsapp_ok boolean default false,
  instagram text,
  linkedin text,
  source text default 'manual',
  legal_basis text default 'pendiente de validar',
  do_not_contact boolean not null default false,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.festival_contacts (
  id uuid primary key default gen_random_uuid(),
  festival_id uuid not null references public.festivals(id) on delete cascade,
  contact_id uuid not null references public.contacts(id) on delete cascade,
  responsibility text,
  priority text default 'media',
  relationship_status text default 'nuevo',
  owner_name text,
  created_at timestamptz not null default now(),
  unique(festival_id, contact_id)
);

create table if not exists public.interactions (
  id uuid primary key default gen_random_uuid(),
  festival_id uuid references public.festivals(id) on delete set null,
  contact_id uuid references public.contacts(id) on delete set null,
  channel text not null check (channel in ('email','instagram','whatsapp','call','meeting','other')),
  direction text not null default 'outbound' check (direction in ('outbound','inbound')),
  message text,
  outcome text,
  next_action_at timestamptz,
  created_by text,
  created_at timestamptz not null default now()
);

create table if not exists public.proposals (
  id uuid primary key default gen_random_uuid(),
  festival_id uuid references public.festivals(id) on delete set null,
  contact_id uuid references public.contacts(id) on delete set null,
  channel text not null check (channel in ('email','instagram','whatsapp','call')),
  objective text,
  subject text,
  body text not null,
  status text not null default 'draft' check (status in ('draft','approved','sent','archived')),
  ai_model text,
  prompt_version text,
  created_by text,
  created_at timestamptz not null default now()
);

create table if not exists public.sources (
  id uuid primary key default gen_random_uuid(),
  festival_id uuid references public.festivals(id) on delete cascade,
  edition_id uuid references public.festival_editions(id) on delete cascade,
  source_type text not null,
  url text,
  extracted_data jsonb,
  confidence text default 'media' check (confidence in ('alta','media','baja')),
  checked_at timestamptz not null default now()
);

create table if not exists public.weekly_snapshots (
  id uuid primary key default gen_random_uuid(),
  festival_id uuid references public.festivals(id) on delete cascade,
  edition_id uuid references public.festival_editions(id) on delete cascade,
  week text not null,
  sales_stage text,
  lifecycle_stage text,
  ticket_status text,
  expected_attendance int,
  diff_from_previous jsonb,
  created_at timestamptz not null default now(),
  unique(edition_id, week)
);

create table if not exists public.radar_alerts (
  id uuid primary key default gen_random_uuid(),
  festival_id uuid references public.festivals(id) on delete cascade,
  title text not null,
  description text,
  severity text not null default 'medium' check (severity in ('low','medium','high')),
  status text not null default 'open' check (status in ('open','done','ignored')),
  created_at timestamptz not null default now()
);

create index if not exists festivals_slug_idx on public.festivals(slug);
create index if not exists editions_festival_year_idx on public.festival_editions(festival_id, year desc);
create index if not exists editions_score_idx on public.festival_editions(opportunity_score desc);
create index if not exists contacts_email_idx on public.contacts(email);
create index if not exists alerts_status_idx on public.radar_alerts(status, created_at desc);

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists festivals_updated_at on public.festivals;
create trigger festivals_updated_at before update on public.festivals for each row execute function public.set_updated_at();

drop trigger if exists festival_editions_updated_at on public.festival_editions;
create trigger festival_editions_updated_at before update on public.festival_editions for each row execute function public.set_updated_at();

drop trigger if exists contacts_updated_at on public.contacts;
create trigger contacts_updated_at before update on public.contacts for each row execute function public.set_updated_at();

create or replace view public.festival_overview as
select distinct on (f.id)
  f.id as festival_id,
  e.id as edition_id,
  f.name,
  f.slug,
  f.official_website,
  f.instagram_url,
  f.ticket_url,
  f.promoter,
  f.main_genres,
  f.status,
  e.year,
  e.start_date,
  e.end_date,
  e.venue_name,
  e.address,
  e.city,
  e.province,
  e.region,
  e.latitude,
  e.longitude,
  e.avg_attendance,
  e.expected_attendance,
  e.sales_stage,
  e.lifecycle_stage,
  e.ticket_status,
  e.opportunity_score,
  e.data_confidence,
  e.last_checked_at
from public.festivals f
left join public.festival_editions e on e.festival_id = f.id
order by f.id, e.year desc nulls last, e.created_at desc;

create or replace view public.radar_alerts_with_festival as
select
  a.*,
  f.name as festival_name
from public.radar_alerts a
left join public.festivals f on f.id = a.festival_id;

create or replace view public.proposals_with_festival as
select
  p.*,
  f.name as festival_name,
  c.name as contact_name
from public.proposals p
left join public.festivals f on f.id = p.festival_id
left join public.contacts c on c.id = p.contact_id;

alter table public.festivals enable row level security;
alter table public.festival_editions enable row level security;
alter table public.contacts enable row level security;
alter table public.festival_contacts enable row level security;
alter table public.interactions enable row level security;
alter table public.proposals enable row level security;
alter table public.sources enable row level security;
alter table public.weekly_snapshots enable row level security;
alter table public.radar_alerts enable row level security;

-- MVP: la aplicación usa SERVICE_ROLE solo en servidor.
-- Si activas Supabase Auth para usuarios nominales, crea políticas específicas para authenticated.
