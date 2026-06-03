insert into public.festivals (name, slug, official_website, instagram_url, main_genres, status)
values
  ('Mad Cool Festival', 'mad-cool-festival', 'https://madcoolfestival.es', 'https://instagram.com/madcoolfestival', array['indie','pop','rock'], 'active'),
  ('Arenal Sound', 'arenal-sound', 'https://www.arenalsound.com', 'https://instagram.com/arenalsound', array['urbano','pop','electrónica'], 'active'),
  ('Festival Cruïlla', 'festival-cruilla', 'https://www.cruillabarcelona.com', 'https://instagram.com/festivalcruilla', array['pop','indie','mestizaje'], 'active'),
  ('Bilbao BBK Live', 'bilbao-bbk-live', 'https://bilbaobbklive.com', 'https://instagram.com/bilbaobbklive', array['indie','rock','electrónica'], 'active')
on conflict (slug) do nothing;

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, avg_attendance, expected_attendance, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-08', '2026-07-11', 'Recinto festival', 'Madrid', 'Madrid', 'Comunidad de Madrid', 70000, 82000, 'Tramo 2', 'Venta activa', 'Disponible', 91, 'media', now()
from public.festivals where slug = 'mad-cool-festival'
on conflict do nothing;

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, avg_attendance, expected_attendance, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-28', '2026-08-02', 'Playa El Arenal', 'Burriana', 'Castellón', 'Comunitat Valenciana', 55000, 60000, 'Últimos abonos', 'Venta avanzada', 'Alta demanda', 86, 'baja', now()
from public.festivals where slug = 'arenal-sound'
on conflict do nothing;

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, avg_attendance, expected_attendance, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-09', '2026-07-12', 'Parc del Fòrum', 'Barcelona', 'Barcelona', 'Cataluña', 45000, 50000, 'Cartel parcial', 'Comunicación activa', 'Disponible', 79, 'media', now()
from public.festivals where slug = 'festival-cruilla'
on conflict do nothing;

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, avg_attendance, expected_attendance, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-09', '2026-07-11', 'Kobetamendi', 'Bilbao', 'Bizkaia', 'País Vasco', 40000, 44000, 'Tramo 1', 'Venta activa', 'Disponible', 75, 'baja', now()
from public.festivals where slug = 'bilbao-bbk-live'
on conflict do nothing;

insert into public.contacts (name, role, company, email, phone, instagram, source, legal_basis, notes)
values
  ('Responsable Marketing Demo', 'Marketing / campañas', 'Promotora demo', 'marketing@example.com', '+34 600 000 000', '@marketing_demo', 'manual', 'contacto profesional público', 'Contacto demo para probar propuestas.'),
  ('Responsable Patrocinios Demo', 'Patrocinios', 'Agencia demo', 'sponsors@example.com', null, '@sponsors_demo', 'manual', 'contacto profesional público', 'Contacto demo.')
on conflict do nothing;

insert into public.festival_contacts (festival_id, contact_id, responsibility, priority, relationship_status)
select f.id, c.id, c.role, 'alta', 'nuevo'
from public.festivals f, public.contacts c
where f.slug = 'mad-cool-festival' and c.email = 'marketing@example.com'
on conflict do nothing;

insert into public.radar_alerts (festival_id, title, description, severity, status)
select id, 'Cambio de tramo detectado', 'Ficha demo en últimos abonos. Revisar fuente y contactar esta semana.', 'high', 'open'
from public.festivals where slug = 'arenal-sound'
on conflict do nothing;
