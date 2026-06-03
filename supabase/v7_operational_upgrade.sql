-- Fiestas Radar v7 - estructura operativa segura
-- Ejecutar una vez en Supabase SQL Editor.

alter table public.festivals
  add column if not exists tiktok_url text,
  add column if not exists source_url text,
  add column if not exists notes text;

alter table public.festival_editions
  add column if not exists commercial_stage text default 'nuevo',
  add column if not exists internal_owner text,
  add column if not exists next_action_at timestamptz,
  add column if not exists last_contacted_at timestamptz,
  add column if not exists ticket_min_price numeric,
  add column if not exists ticket_max_price numeric,
  add column if not exists ticket_url text,
  add column if not exists attendance_source text,
  add column if not exists price_source text;

create table if not exists public.radar_runs (
  id uuid primary key default gen_random_uuid(),
  source text not null default 'manual',
  status text not null default 'done',
  imported_count integer not null default 0,
  updated_count integer not null default 0,
  alert_count integer not null default 0,
  raw_result jsonb,
  created_at timestamptz not null default now()
);

create index if not exists festival_editions_commercial_stage_idx on public.festival_editions (commercial_stage);
create index if not exists festival_editions_start_date_idx on public.festival_editions (start_date);
create index if not exists festival_editions_score_idx on public.festival_editions (opportunity_score desc);

create or replace view public.festival_overview as
select
  f.id as festival_id,
  e.id as edition_id,
  f.name,
  f.slug,
  f.official_website,
  f.instagram_url,
  f.tiktok_url,
  coalesce(e.ticket_url, f.official_website) as ticket_url,
  f.main_genres,
  e.year,
  e.start_date,
  e.end_date,
  e.venue_name,
  e.city,
  e.province,
  e.region,
  e.latitude,
  e.longitude,
  e.avg_attendance,
  e.expected_attendance,
  e.ticket_min_price,
  e.ticket_max_price,
  e.sales_stage,
  e.lifecycle_stage,
  coalesce(e.commercial_stage, 'nuevo') as commercial_stage,
  e.ticket_status,
  e.opportunity_score,
  e.last_checked_at,
  e.data_confidence,
  f.source_url,
  f.notes
from public.festivals f
left join lateral (
  select *
  from public.festival_editions fe
  where fe.festival_id = f.id
  order by
    case when fe.start_date >= current_date then 0 else 1 end,
    fe.start_date asc nulls last,
    fe.year desc nulls last
  limit 1
) e on true
where coalesce(f.status, 'active') <> 'archived';

-- Normaliza estados existentes que puedan venir de versiones anteriores.
update public.festival_editions
set commercial_stage = 'nuevo'
where commercial_stage is null;
