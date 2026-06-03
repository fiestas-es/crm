-- Fiestas Radar: base inicial pública de festivales España.
-- Datos orientativos. Revisar fecha, tramo y asistencia antes de contactar.
begin;

insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Undersea Festival', 'undersea-festival', 'https://underseafestival.com', 'https://instagram.com/undersea_festival', null, array['urbano','electrónica','remember'], 'active', 'Festival acuático en Terra Mítica; objetivo superar 8.000 asistentes.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-06-13', '2026-06-13', null, 'Benidorm', 'Alicante', 'Comunitat Valenciana', 38.5382, -0.131, 8000, 'https://underseafestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'media', now()
from public.festivals where slug = 'undersea-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://underseafestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'undersea-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Costa Sonora', 'costa-sonora', 'https://www.costasonora.es', 'https://instagram.com/costasonorafest', null, array['urbano','trap','reggaeton'], 'active', 'Festival urbano de Alicante; miles de asistentes.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2027, '2027-03-26', '2027-03-27', null, 'Alicante', 'Alicante', 'Comunitat Valenciana', 38.3452, -0.481, 6000, 'https://www.costasonora.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 51, 'media', now()
from public.festivals where slug = 'costa-sonora'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.costasonora.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'costa-sonora';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Riverland Fest', 'riverland-fest', 'https://www.riverlandfest.com', 'https://instagram.com/riverland.fest', null, array['urbano','indie','electrónica'], 'active', 'Asturias, buses, camping y venta activa.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-08-21', '2026-08-23', null, 'Coviella / Arriondas', 'Asturias', 'Asturias', 43.385, -5.185, 10000, 'https://www.riverlandfest.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 55, 'media', now()
from public.festivals where slug = 'riverland-fest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.riverlandfest.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'riverland-fest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Aquasella', 'aquasella', 'https://aquasella.com', 'https://instagram.com/aquasellafest', null, array['techno','electrónica'], 'active', 'Electrónica en Asturias.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-08-13', '2026-08-16', null, 'Arriondas / Cangas de Onís', 'Asturias', 'Asturias', 43.386, -5.184, 25000, 'https://aquasella.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'aquasella'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://aquasella.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'aquasella';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Mad Cool Festival', 'mad-cool-festival', 'https://madcoolfestival.es', 'https://instagram.com/madcoolfestival', null, array['indie','pop','rock'], 'active', 'Macrofestival prioritario.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-07', '2026-07-11', null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.333, -3.689, 82000, 'https://madcoolfestival.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'mad-cool-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://madcoolfestival.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'mad-cool-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Arenal Sound', 'arenal-sound', 'https://www.arenalsound.com', 'https://instagram.com/arenalsound', null, array['urbano','pop','electrónica'], 'active', 'Macrofestival playa.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-28', '2026-08-02', null, 'Burriana', 'Castellón', 'Comunitat Valenciana', 39.8895, -0.078, 60000, 'https://www.arenalsound.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'arenal-sound'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.arenalsound.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'arenal-sound';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Festival Cruïlla', 'festival-cruilla', 'https://www.cruillabarcelona.com', 'https://instagram.com/festivalcruilla', null, array['pop','indie','mestizaje'], 'active', 'Parc del Fòrum.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-08', '2026-07-11', null, 'Barcelona', 'Barcelona', 'Cataluña', 41.411, 2.226, 50000, 'https://www.cruillabarcelona.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'festival-cruilla'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.cruillabarcelona.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'festival-cruilla';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Bilbao BBK Live', 'bilbao-bbk-live', 'https://bilbaobbklive.com', 'https://instagram.com/bilbaobbklive', null, array['indie','rock','electrónica'], 'active', 'Kobetamendi.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-09', '2026-07-11', null, 'Bilbao', 'Bizkaia', 'País Vasco', 43.2596, -2.9639, 44000, 'https://bilbaobbklive.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 89, 'media', now()
from public.festivals where slug = 'bilbao-bbk-live'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://bilbaobbklive.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'bilbao-bbk-live';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Primavera Sound Barcelona', 'primavera-sound-barcelona', 'https://www.primaverasound.com', 'https://instagram.com/primavera_sound', null, array['indie','pop','electrónica','urbano'], 'active', 'Parc del Fòrum.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-06-03', '2026-06-07', null, 'Barcelona', 'Barcelona', 'Cataluña', 41.411, 2.226, 75000, 'https://www.primaverasound.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'primavera-sound-barcelona'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.primaverasound.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'primavera-sound-barcelona';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Sónar Barcelona', 'sonar-barcelona', 'https://sonar.es', 'https://instagram.com/sonarfestival', null, array['electrónica','cultura digital'], 'active', 'Electrónica.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-06-18', '2026-06-20', null, 'L’Hospitalet de Llobregat', 'Barcelona', 'Cataluña', 41.3548, 2.1283, 45000, 'https://sonar.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 90, 'media', now()
from public.festivals where slug = 'sonar-barcelona'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://sonar.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'sonar-barcelona';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Viña Rock', 'vina-rock', 'https://www.vina-rock.com', 'https://instagram.com/vinarockoficial', null, array['rock','punk','rap','mestizaje'], 'active', 'Villarrobledo.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-04-30', '2026-05-02', null, 'Villarrobledo', 'Albacete', 'Castilla-La Mancha', 39.2699, -2.6012, 60000, 'https://www.vina-rock.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'vina-rock'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.vina-rock.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'vina-rock';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Resurrection Fest', 'resurrection-fest', 'https://www.resurrectionfest.es', 'https://instagram.com/resurrectionfest', null, array['metal','rock','punk'], 'active', 'Gran evento rock/metal.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Viveiro', 'Lugo', 'Galicia', 43.6636, -7.5948, 100000, 'https://www.resurrectionfest.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'resurrection-fest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.resurrectionfest.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'resurrection-fest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('O Son do Camiño', 'o-son-do-camino', 'https://www.osondocamino.es', 'https://instagram.com/osondocamino', null, array['pop','rock','urbano'], 'active', 'Monte do Gozo.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-06-18', '2026-06-20', null, 'Santiago de Compostela', 'A Coruña', 'Galicia', 42.8782, -8.5448, 42000, 'https://www.osondocamino.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 87, 'media', now()
from public.festivals where slug = 'o-son-do-camino'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.osondocamino.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'o-son-do-camino';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Dreambeach', 'dreambeach', 'https://dreambeach.es', 'https://instagram.com/dreambeachfestival', null, array['electrónica','techno','urban'], 'active', 'Electrónica en Andalucía.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'El Ejido / Almería', 'Almería', 'Andalucía', 36.7763, -2.8146, 35000, 'https://dreambeach.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 80, 'media', now()
from public.festivals where slug = 'dreambeach'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://dreambeach.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'dreambeach';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Medusa Festival', 'medusa-festival', 'https://medusasunbeach.com', 'https://instagram.com/medusasunbeach', null, array['electrónica','techno','EDM'], 'active', 'Macrofestival electrónico.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Cullera', 'Valencia', 'Comunitat Valenciana', 39.1647, -0.2544, 60000, 'https://medusasunbeach.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'medusa-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://medusasunbeach.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'medusa-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Zevra Festival', 'zevra-festival', 'https://zevrafestival.com', 'https://instagram.com/zevrafestival', null, array['urbano','reggaeton','pop'], 'active', 'Urbano/pop en Cullera.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Cullera', 'Valencia', 'Comunitat Valenciana', 39.1647, -0.2544, 40000, 'https://zevrafestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 85, 'media', now()
from public.festivals where slug = 'zevra-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://zevrafestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'zevra-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Madrid Salvaje', 'madrid-salvaje', 'https://madridsalvaje.com', 'https://instagram.com/madridsalvaje', null, array['urbano','rap','reggaeton'], 'active', 'Urbano en Madrid.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 30000, 'https://madridsalvaje.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'madrid-salvaje'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://madridsalvaje.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'madrid-salvaje';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Rocanrola', 'rocanrola', 'https://rocanrolafestival.com', 'https://instagram.com/rocanrolafestival', null, array['rap','hip hop','urbano'], 'active', 'Rap/urbano.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Alicante', 'Alicante', 'Comunitat Valenciana', 38.3452, -0.481, 25000, 'https://rocanrolafestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'rocanrola'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://rocanrolafestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'rocanrola';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('elrow Town Madrid', 'elrow-town-madrid', 'https://elrow.com', 'https://instagram.com/elrowofficial', null, array['electrónica','tech house'], 'active', 'Evento festivalero de electrónica.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 25000, 'https://elrow.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'elrow-town-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://elrow.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'elrow-town-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('elrow Town Marbella', 'elrow-town-marbella', 'https://elrow.com', 'https://instagram.com/elrowofficial', null, array['electrónica','tech house'], 'active', 'Evento festivalero en Marbella.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Marbella', 'Málaga', 'Andalucía', 36.5101, -4.8824, 15000, 'https://elrow.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 60, 'baja', now()
from public.festivals where slug = 'elrow-town-marbella'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://elrow.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'elrow-town-marbella';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Boombastic Asturias', 'boombastic-asturias', 'https://boombasticfestival.com', 'https://instagram.com/boombastic_festival', null, array['urbano','pop','reggaeton'], 'active', 'Festival urbano.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Llanera', 'Asturias', 'Asturias', 43.4611, -5.9311, 40000, 'https://boombasticfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 85, 'media', now()
from public.festivals where slug = 'boombastic-asturias'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://boombasticfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'boombastic-asturias';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Boombastic Madrid', 'boombastic-madrid', 'https://boombasticfestival.com', 'https://instagram.com/boombastic_festival', null, array['urbano','pop','reggaeton'], 'active', 'Festival urbano.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 30000, 'https://boombasticfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'boombastic-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://boombasticfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'boombastic-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Boombastic Costa del Sol', 'boombastic-costa-del-sol', 'https://boombasticfestival.com', 'https://instagram.com/boombastic_festival', null, array['urbano','pop','reggaeton'], 'active', 'Festival urbano.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Fuengirola', 'Málaga', 'Andalucía', 36.539, -4.6244, 25000, 'https://boombasticfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'boombastic-costa-del-sol'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://boombasticfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'boombastic-costa-del-sol';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Cabo de Plata', 'cabo-de-plata', 'https://cabodeplata.com', 'https://instagram.com/cabodeplata', null, array['mestizaje','rock','urbano','reggae'], 'active', 'Barbate.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Barbate', 'Cádiz', 'Andalucía', 36.1924, -5.9219, 30000, 'https://cabodeplata.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'cabo-de-plata'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://cabodeplata.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'cabo-de-plata';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Marenostrum Fuengirola', 'marenostrum-fuengirola', 'https://marenostrumfuengirola.com', 'https://instagram.com/marenostrumfuengirola', null, array['pop','urbano','electrónica'], 'active', 'Ciclo/festival en Fuengirola.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Fuengirola', 'Málaga', 'Andalucía', 36.5346, -4.6258, 18000, 'https://marenostrumfuengirola.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 63, 'media', now()
from public.festivals where slug = 'marenostrum-fuengirola'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://marenostrumfuengirola.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'marenostrum-fuengirola';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Reggaeton Beach Festival Barcelona', 'reggaeton-beach-festival-barcelona', 'https://reggaetonbeachfestival.com', 'https://instagram.com/reggaetonbeachfestival', null, array['reggaeton','urbano'], 'active', 'Festival urbano itinerante.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Barcelona', 'Barcelona', 'Cataluña', 41.3851, 2.1734, 35000, 'https://reggaetonbeachfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 80, 'media', now()
from public.festivals where slug = 'reggaeton-beach-festival-barcelona'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://reggaetonbeachfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'reggaeton-beach-festival-barcelona';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Reggaeton Beach Festival Madrid', 'reggaeton-beach-festival-madrid', 'https://reggaetonbeachfestival.com', 'https://instagram.com/reggaetonbeachfestival', null, array['reggaeton','urbano'], 'active', 'Festival urbano itinerante.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 35000, 'https://reggaetonbeachfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 80, 'media', now()
from public.festivals where slug = 'reggaeton-beach-festival-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://reggaetonbeachfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'reggaeton-beach-festival-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Reggaeton Beach Festival Benidorm', 'reggaeton-beach-festival-benidorm', 'https://reggaetonbeachfestival.com', 'https://instagram.com/reggaetonbeachfestival', null, array['reggaeton','urbano'], 'active', 'Festival urbano itinerante.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Benidorm', 'Alicante', 'Comunitat Valenciana', 38.5411, -0.1225, 25000, 'https://reggaetonbeachfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'reggaeton-beach-festival-benidorm'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://reggaetonbeachfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'reggaeton-beach-festival-benidorm';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Holika', 'holika', 'https://holikafestival.com', 'https://instagram.com/holikafestival', null, array['urbano','pop','electrónica'], 'active', 'Festival urbano/pop.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Calahorra', 'La Rioja', 'La Rioja', 42.305, -1.965, 20000, 'https://holikafestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 65, 'media', now()
from public.festivals where slug = 'holika'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://holikafestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'holika';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Puro Latino Sevilla', 'puro-latino-sevilla', 'https://purolatino.es', 'https://instagram.com/purolatino_fest', null, array['latino','reggaeton','urbano'], 'active', 'Festival latino.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Sevilla', 'Sevilla', 'Andalucía', 37.3886, -5.9823, 30000, 'https://purolatino.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'puro-latino-sevilla'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://purolatino.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'puro-latino-sevilla';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Puro Latino El Puerto de Santa María', 'puro-latino-el-puerto-de-santa-maria', 'https://purolatino.es', 'https://instagram.com/purolatino_fest', null, array['latino','reggaeton','urbano'], 'active', 'Festival latino.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'El Puerto de Santa María', 'Cádiz', 'Andalucía', 36.6015, -6.238, 30000, 'https://purolatino.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'puro-latino-el-puerto-de-santa-maria'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://purolatino.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'puro-latino-el-puerto-de-santa-maria';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Pirata Beach Festival', 'pirata-beach-festival', 'https://piratafestival.com', 'https://instagram.com/pirata_beach_festival', null, array['rock','mestizaje','urbano'], 'active', 'Gandia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Gandia', 'Valencia', 'Comunitat Valenciana', 38.968, -0.18, 30000, 'https://piratafestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'pirata-beach-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://piratafestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'pirata-beach-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Low Festival', 'low-festival', 'https://lowfestival.es', 'https://instagram.com/lowfestival', null, array['indie','pop','rock'], 'active', 'Benidorm.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Benidorm', 'Alicante', 'Comunitat Valenciana', 38.5411, -0.1225, 25000, 'https://lowfestival.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'low-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://lowfestival.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'low-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('FIB Benicàssim', 'fib-benicassim', 'https://fiberfib.com', 'https://instagram.com/fibfestival', null, array['indie','pop','rock'], 'active', 'Benicàssim.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Benicàssim', 'Castellón', 'Comunitat Valenciana', 40.055, 0.064, 40000, 'https://fiberfib.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 85, 'media', now()
from public.festivals where slug = 'fib-benicassim'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://fiberfib.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'fib-benicassim';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Rototom Sunsplash', 'rototom-sunsplash', 'https://rototomsunsplash.com', 'https://instagram.com/rototomsunsplash', null, array['reggae','world','mestizaje'], 'active', 'Reggae.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Benicàssim', 'Castellón', 'Comunitat Valenciana', 40.055, 0.064, 20000, 'https://rototomsunsplash.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 65, 'media', now()
from public.festivals where slug = 'rototom-sunsplash'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://rototomsunsplash.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'rototom-sunsplash';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('SanSan Festival', 'sansan-festival', 'https://sansanfestival.com', 'https://instagram.com/sansanfestival', null, array['indie','pop'], 'active', 'Benicàssim.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-04-02', '2026-04-04', null, 'Benicàssim', 'Castellón', 'Comunitat Valenciana', 40.055, 0.064, 25000, 'https://sansanfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'sansan-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://sansanfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'sansan-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Sonorama Ribera', 'sonorama-ribera', 'https://sonorama-aranda.com', 'https://instagram.com/sonorama_ribera', null, array['indie','pop','rock'], 'active', 'Aranda de Duero.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Aranda de Duero', 'Burgos', 'Castilla y León', 41.6704, -3.6892, 30000, 'https://sonorama-aranda.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'sonorama-ribera'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://sonorama-aranda.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'sonorama-ribera';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Mallorca Live Festival', 'mallorca-live-festival', 'https://mallorcalivemusic.com', 'https://instagram.com/mallorcalivefestival', null, array['indie','pop','electrónica','urbano'], 'active', 'Mallorca.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Calvià', 'Illes Balears', 'Illes Balears', 39.5654, 2.5062, 25000, 'https://mallorcalivemusic.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'mallorca-live-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://mallorcalivemusic.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'mallorca-live-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('A Summer Story', 'a-summer-story', 'https://asummerstory.com', 'https://instagram.com/asummerstoryoficial', null, array['electrónica','EDM','techno'], 'active', 'Ciudad del Rock.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Arganda del Rey', 'Madrid', 'Comunidad de Madrid', 40.3008, -3.4372, 35000, 'https://asummerstory.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 80, 'media', now()
from public.festivals where slug = 'a-summer-story'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://asummerstory.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'a-summer-story';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Monegros Desert Festival', 'monegros-desert-festival', 'https://monegrosfestival.com', 'https://instagram.com/monegrosfestival', null, array['electrónica','techno','drum and bass'], 'active', 'Desierto de Monegros.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Fraga', 'Huesca', 'Aragón', 41.522, 0.3487, 50000, 'https://monegrosfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 95, 'media', now()
from public.festivals where slug = 'monegros-desert-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://monegrosfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'monegros-desert-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Brava Madrid', 'brava-madrid', 'https://bravamadrid.com', 'https://instagram.com/bravamadrid', null, array['pop','electrónica','fiesta'], 'active', 'Festival pop/fiesta.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 18000, 'https://bravamadrid.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 63, 'baja', now()
from public.festivals where slug = 'brava-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://bravamadrid.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'brava-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Brava Barcelona', 'brava-barcelona', 'https://bravafestival.com', 'https://instagram.com/bravafestival', null, array['pop','electrónica','fiesta'], 'active', 'Festival pop/fiesta.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Barcelona', 'Barcelona', 'Cataluña', 41.3851, 2.1734, 15000, 'https://bravafestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 60, 'baja', now()
from public.festivals where slug = 'brava-barcelona'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://bravafestival.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'brava-barcelona';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Bella Festival', 'bella-festival', null, 'https://instagram.com/bellafestival', null, array['pop','urbano','electrónica'], 'active', 'Marbella.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Marbella', 'Málaga', 'Andalucía', 36.5101, -4.8824, 12000, 'https://instagram.com/bellafestival', 'Detectado', 'Pendiente de validar', 'Pendiente', 57, 'baja', now()
from public.festivals where slug = 'bella-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://instagram.com/bellafestival', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'bella-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Polar Sound', 'polar-sound', 'https://polarsoundfestival.com', 'https://instagram.com/polarsoundfestival', null, array['indie','pop','electrónica'], 'active', 'Festival de nieve.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Baqueira Beret', 'Lleida', 'Cataluña', 42.7005, 0.9305, 8000, 'https://polarsoundfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'polar-sound'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://polarsoundfestival.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'polar-sound';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Negrita Music Festival Santander', 'negrita-music-festival-santander', 'https://negritamusicfestival.com', 'https://instagram.com/negritamusicfestival', null, array['urbano','pop','reggaeton'], 'active', 'Santander.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Santander', 'Cantabria', 'Cantabria', 43.4623, -3.8099, 20000, 'https://negritamusicfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 65, 'media', now()
from public.festivals where slug = 'negrita-music-festival-santander'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://negritamusicfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'negrita-music-festival-santander';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Negrita Music Festival Alicante', 'negrita-music-festival-alicante', 'https://negritamusicfestival.com', 'https://instagram.com/negritamusicfestival', null, array['urbano','pop','reggaeton'], 'active', 'Alicante.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Alicante', 'Alicante', 'Comunitat Valenciana', 38.3452, -0.481, 20000, 'https://negritamusicfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 65, 'media', now()
from public.festivals where slug = 'negrita-music-festival-alicante'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://negritamusicfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'negrita-music-festival-alicante';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Interestelar Sevilla', 'interestelar-sevilla', 'https://interestelarsevilla.com', 'https://instagram.com/interestelarsevilla', null, array['indie','pop','rock'], 'active', 'Sevilla.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Sevilla', 'Sevilla', 'Andalucía', 37.3886, -5.9823, 18000, 'https://interestelarsevilla.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 63, 'media', now()
from public.festivals where slug = 'interestelar-sevilla'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://interestelarsevilla.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'interestelar-sevilla';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Granada Sound', 'granada-sound', 'https://granadasound.com', 'https://instagram.com/granadasound', null, array['indie','pop','rock'], 'active', 'Granada.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Granada', 'Granada', 'Andalucía', 37.1773, -3.5986, 22000, 'https://granadasound.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 67, 'media', now()
from public.festivals where slug = 'granada-sound'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://granadasound.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'granada-sound';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('WARM UP Estrella de Levante', 'warm-up-estrella-de-levante', 'https://warmupfestival.es', 'https://instagram.com/warmupfestival', null, array['indie','pop','electrónica'], 'active', 'Murcia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Murcia', 'Murcia', 'Región de Murcia', 37.9922, -1.1307, 25000, 'https://warmupfestival.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'warm-up-estrella-de-levante'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://warmupfestival.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'warm-up-estrella-de-levante';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Festival de Les Arts', 'festival-de-les-arts', 'https://festivaldelesarts.com', 'https://instagram.com/festivaldelesarts', null, array['indie','pop'], 'active', 'Valencia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Valencia', 'Valencia', 'Comunitat Valenciana', 39.4699, -0.3763, 20000, 'https://festivaldelesarts.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 65, 'media', now()
from public.festivals where slug = 'festival-de-les-arts'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://festivaldelesarts.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'festival-de-les-arts';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Fan Futura Fest', 'fan-futura-fest', 'https://fanfutura.com', 'https://instagram.com/fanfuturafest', null, array['electrónica','urbano','pop'], 'active', 'San Javier.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'San Javier', 'Murcia', 'Región de Murcia', 37.8063, -0.8375, 12000, 'https://fanfutura.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 57, 'baja', now()
from public.festivals where slug = 'fan-futura-fest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://fanfutura.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'fan-futura-fest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Sierra Sur Festival', 'sierra-sur-festival', 'https://sierrasurfestival.com', 'https://instagram.com/sierrasurfestival', null, array['indie','world','mestizaje'], 'active', 'Festival boutique.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Zahara de la Sierra', 'Cádiz', 'Andalucía', 36.8406, -5.39, 6000, 'https://sierrasurfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 51, 'baja', now()
from public.festivals where slug = 'sierra-sur-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://sierrasurfestival.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'sierra-sur-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Noches del Botánico', 'noches-del-botanico', 'https://nochesdelbotanico.com', 'https://instagram.com/nochesbotanico', null, array['pop','jazz','world','indie'], 'active', 'Ciclo/festival Madrid.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.446, -3.729, 9000, 'https://nochesdelbotanico.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 54, 'media', now()
from public.festivals where slug = 'noches-del-botanico'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://nochesdelbotanico.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'noches-del-botanico';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Love the 90s Madrid', 'love-the-90s-madrid', 'https://www.love90s.es', 'https://instagram.com/love90sfestival', null, array['remember','dance','pop'], 'active', 'IFEMA Madrid.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-06-13', '2026-06-13', null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.462, -3.617, 30000, 'https://www.love90s.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'love-the-90s-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.love90s.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'love-the-90s-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('I Love Reggaeton Madrid', 'i-love-reggaeton-madrid', 'https://ilovereggaeton.es', 'https://instagram.com/ilovereggaetonfestival', null, array['reggaeton','urbano','remember'], 'active', 'IFEMA Madrid.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-06-06', '2026-06-06', null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.462, -3.617, 25000, 'https://ilovereggaeton.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'i-love-reggaeton-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://ilovereggaeton.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'i-love-reggaeton-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Río Babel', 'rio-babel', 'https://festivalriobabel.com', 'https://instagram.com/festivalriobabel', null, array['latino','pop','rock'], 'active', 'Rivas.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-03', '2026-07-05', null, 'Rivas-Vaciamadrid', 'Madrid', 'Comunidad de Madrid', 40.334, -3.52, 30000, 'https://festivalriobabel.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'rio-babel'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://festivalriobabel.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'rio-babel';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Barcelona Rock Fest', 'barcelona-rock-fest', 'https://barcelonarockfest.com', 'https://instagram.com/barcelonarockfest', null, array['rock','metal'], 'active', 'Parc de Can Zam.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-03', '2026-07-05', null, 'Santa Coloma de Gramenet', 'Barcelona', 'Cataluña', 41.4515, 2.2081, 35000, 'https://barcelonarockfest.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 80, 'media', now()
from public.festivals where slug = 'barcelona-rock-fest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://barcelonarockfest.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'barcelona-rock-fest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Rock Imperium Festival', 'rock-imperium-festival', 'https://rockimperiumfestival.es', 'https://instagram.com/rockimperiumfestival', null, array['rock','metal'], 'active', 'Cartagena.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-03', '2026-07-05', null, 'Cartagena', 'Murcia', 'Región de Murcia', 37.6257, -0.9966, 25000, 'https://rockimperiumfestival.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'rock-imperium-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://rockimperiumfestival.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'rock-imperium-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Azkena Rock Festival', 'azkena-rock-festival', 'https://azkenarockfestival.com', 'https://instagram.com/azkenarockfest', null, array['rock','americana'], 'active', 'Vitoria.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Vitoria-Gasteiz', 'Álava', 'País Vasco', 42.8467, -2.6727, 18000, 'https://azkenarockfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 63, 'media', now()
from public.festivals where slug = 'azkena-rock-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://azkenarockfestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'azkena-rock-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('CanelaParty', 'canelaparty', 'https://canelaparty.com', 'https://instagram.com/canelaparty', null, array['indie','punk','rock'], 'active', 'Málaga.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Torremolinos', 'Málaga', 'Andalucía', 36.6243, -4.4998, 8000, 'https://canelaparty.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'canelaparty'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://canelaparty.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'canelaparty';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Vida Festival', 'vida-festival', 'https://vidafestival.com', 'https://instagram.com/vidafestival', null, array['indie','pop'], 'active', 'Vilanova.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Vilanova i la Geltrú', 'Barcelona', 'Cataluña', 41.2239, 1.7251, 12000, 'https://vidafestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 57, 'media', now()
from public.festivals where slug = 'vida-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://vidafestival.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'vida-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('PortAmérica', 'portamerica', 'https://portamerica.es', 'https://instagram.com/portamerica', null, array['pop','indie','mestizaje','gastro'], 'active', 'Galicia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Caldas de Reis', 'Pontevedra', 'Galicia', 42.6047, -8.6424, 25000, 'https://portamerica.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'portamerica'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://portamerica.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'portamerica';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Atlantic Fest', 'atlantic-fest', 'https://atlanticfest.com', 'https://instagram.com/atlantic_fest', null, array['indie','pop'], 'active', 'Galicia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Vilagarcía de Arousa', 'Pontevedra', 'Galicia', 42.5963, -8.7652, 8000, 'https://atlanticfest.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'atlantic-fest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://atlanticfest.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'atlantic-fest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('SonRías Baixas', 'sonrias-baixas', 'https://sonriasbaixas.info', 'https://instagram.com/sonriasbaixas', null, array['mestizaje','rock','rap'], 'active', 'Bueu.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Bueu', 'Pontevedra', 'Galicia', 42.3237, -8.784, 10000, 'https://sonriasbaixas.info', 'Detectado', 'Pendiente de validar', 'Pendiente', 55, 'media', now()
from public.festivals where slug = 'sonrias-baixas'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://sonriasbaixas.info', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'sonrias-baixas';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Revenidas', 'revenidas', 'https://revenidas.com', 'https://instagram.com/revenidas', null, array['mestizaje','rock','reggae'], 'active', 'Galicia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Vilaxoán', 'Pontevedra', 'Galicia', 42.5867, -8.7713, 8000, 'https://revenidas.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'revenidas'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://revenidas.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'revenidas';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Noroeste Estrella Galicia', 'noroeste-estrella-galicia', 'https://festivalnoroeste.com', 'https://instagram.com/noroestefestival', null, array['pop','rock','indie'], 'active', 'A Coruña.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'A Coruña', 'A Coruña', 'Galicia', 43.3623, -8.4115, 20000, 'https://festivalnoroeste.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 65, 'media', now()
from public.festivals where slug = 'noroeste-estrella-galicia'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://festivalnoroeste.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'noroeste-estrella-galicia';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Icónica Santalucía Sevilla Fest', 'iconica-santalucia-sevilla-fest', 'https://iconicafest.com', 'https://instagram.com/iconicafest', null, array['pop','rock','flamenco','world'], 'active', 'Plaza de España; ciclo festival.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-06-04', '2026-07-18', null, 'Sevilla', 'Sevilla', 'Andalucía', 37.3772, -5.9869, 30000, 'https://iconicafest.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'iconica-santalucia-sevilla-fest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://iconicafest.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'iconica-santalucia-sevilla-fest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Starlite Occident', 'starlite-occident', 'https://starliteoccident.com', 'https://instagram.com/starliteoccident', null, array['pop','latino','flamenco'], 'active', 'Marbella.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Marbella', 'Málaga', 'Andalucía', 36.5101, -4.8824, 30000, 'https://starliteoccident.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'starlite-occident'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://starliteoccident.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'starlite-occident';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Festival Jardins de Pedralbes / Alma Barcelona', 'festival-jardins-de-pedralbes-alma-barcelona', 'https://almafestival.info', 'https://instagram.com/almafestival', null, array['pop','jazz','world'], 'active', 'Barcelona.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Barcelona', 'Barcelona', 'Cataluña', 41.3902, 2.1177, 15000, 'https://almafestival.info', 'Detectado', 'Pendiente de validar', 'Pendiente', 60, 'media', now()
from public.festivals where slug = 'festival-jardins-de-pedralbes-alma-barcelona'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://almafestival.info', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'festival-jardins-de-pedralbes-alma-barcelona';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Alma Madrid', 'alma-madrid', 'https://almafestival.info', 'https://instagram.com/almafestival', null, array['pop','jazz','world'], 'active', 'Madrid.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 15000, 'https://almafestival.info', 'Detectado', 'Pendiente de validar', 'Pendiente', 60, 'media', now()
from public.festivals where slug = 'alma-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://almafestival.info', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'alma-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Festival Mil·lenni', 'festival-millenni', 'https://festival-millenni.com', 'https://instagram.com/festivalmillenni', null, array['pop','rock','autor'], 'active', 'Barcelona.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Barcelona', 'Barcelona', 'Cataluña', 41.3851, 2.1734, 8000, 'https://festival-millenni.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'festival-millenni'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://festival-millenni.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'festival-millenni';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Share Festival', 'share-festival', 'https://sharefestival.org', 'https://instagram.com/sharefestival', null, array['urbano','pop'], 'active', 'Barcelona.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Barcelona', 'Barcelona', 'Cataluña', 41.3851, 2.1734, 25000, 'https://sharefestival.org', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'share-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://sharefestival.org', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'share-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Coca-Cola Music Experience', 'coca-cola-music-experience', 'https://www.coca-cola.es/music-experience', 'https://instagram.com/cocacolamusicexperience', null, array['pop','urbano'], 'active', 'Madrid.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 30000, 'https://www.coca-cola.es/music-experience', 'Detectado', 'Pendiente de validar', 'Pendiente', 75, 'media', now()
from public.festivals where slug = 'coca-cola-music-experience'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.coca-cola.es/music-experience', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'coca-cola-music-experience';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Festival Gigante', 'festival-gigante', 'https://festivalgigante.com', 'https://instagram.com/festivalgigante', null, array['indie','pop','rock'], 'active', 'Alcalá de Henares.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Alcalá de Henares', 'Madrid', 'Comunidad de Madrid', 40.4819, -3.3635, 15000, 'https://festivalgigante.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 60, 'media', now()
from public.festivals where slug = 'festival-gigante'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://festivalgigante.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'festival-gigante';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('MUWI La Rioja Music Fest', 'muwi-la-rioja-music-fest', 'https://muwi.es', 'https://instagram.com/muwilarioja', null, array['indie','pop','gastro'], 'active', 'Logroño.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Logroño', 'La Rioja', 'La Rioja', 42.4627, -2.4449, 8000, 'https://muwi.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'muwi-la-rioja-music-fest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://muwi.es', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'muwi-la-rioja-music-fest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Fárdelej', 'fardelej', 'https://fardelej.com', 'https://instagram.com/fardelej', null, array['indie','pop'], 'active', 'Arnedo.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Arnedo', 'La Rioja', 'La Rioja', 42.2288, -2.1004, 6000, 'https://fardelej.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 51, 'baja', now()
from public.festivals where slug = 'fardelej'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://fardelej.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'fardelej';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Actual Festival', 'actual-festival', 'https://actualfestival.com', 'https://instagram.com/actualfestival', null, array['indie','pop','cultura'], 'active', 'Logroño.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Logroño', 'La Rioja', 'La Rioja', 42.4627, -2.4449, 8000, 'https://actualfestival.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'actual-festival'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://actualfestival.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'actual-festival';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Contempopránea', 'contempopranea', 'https://contempopranea.com', 'https://instagram.com/contempopranea', null, array['indie','pop'], 'active', 'Extremadura.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Olivenza', 'Badajoz', 'Extremadura', 38.684, -7.1, 6000, 'https://contempopranea.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 51, 'baja', now()
from public.festivals where slug = 'contempopranea'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://contempopranea.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'contempopranea';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Extremúsika', 'extremusika', 'https://extremusika.es', 'https://instagram.com/extremusika', null, array['rock','mestizaje','rap'], 'active', 'Cáceres.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Cáceres', 'Cáceres', 'Extremadura', 39.4753, -6.3724, 20000, 'https://extremusika.es', 'Detectado', 'Pendiente de validar', 'Pendiente', 65, 'media', now()
from public.festivals where slug = 'extremusika'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://extremusika.es', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'extremusika';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Ebrovisión', 'ebrovision', 'https://ebrovision.com', 'https://instagram.com/ebrovision', null, array['indie','pop','rock'], 'active', 'Miranda de Ebro.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Miranda de Ebro', 'Burgos', 'Castilla y León', 42.6865, -2.9469, 8000, 'https://ebrovision.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'ebrovision'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://ebrovision.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'ebrovision';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Palencia Sonora', 'palencia-sonora', 'https://palenciasonora.com', 'https://instagram.com/palenciasonora', null, array['indie','pop','rock'], 'active', 'Palencia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Palencia', 'Palencia', 'Castilla y León', 42.0095, -4.5288, 8000, 'https://palenciasonora.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 53, 'baja', now()
from public.festivals where slug = 'palencia-sonora'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://palenciasonora.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'palencia-sonora';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Wintable / Inverfest', 'wintable-inverfest', 'https://www.inverfest.com', 'https://instagram.com/inverfest', null, array['pop','indie','autor'], 'active', 'Ciclo festival.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 12000, 'https://www.inverfest.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 57, 'baja', now()
from public.festivals where slug = 'wintable-inverfest'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://www.inverfest.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'wintable-inverfest';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Kalorama Madrid', 'kalorama-madrid', 'https://kaloramamadrid.com', 'https://instagram.com/kaloramamadrid', null, array['indie','pop','electrónica'], 'active', 'Madrid.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Madrid', 'Madrid', 'Comunidad de Madrid', 40.4168, -3.7038, 25000, 'https://kaloramamadrid.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 70, 'media', now()
from public.festivals where slug = 'kalorama-madrid'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://kaloramamadrid.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'kalorama-madrid';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Tsunami Xixón', 'tsunami-xixon', 'https://tsunamixixon.com', 'https://instagram.com/tsunamixixon', null, array['punk','rock','metal'], 'active', 'Gijón.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Gijón', 'Asturias', 'Asturias', 43.5322, -5.6611, 12000, 'https://tsunamixixon.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 57, 'media', now()
from public.festivals where slug = 'tsunami-xixon'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://tsunamixixon.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'tsunami-xixon';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Festival Internacional de Benicàssim', 'festival-internacional-de-benicassim', 'https://fiberfib.com', 'https://instagram.com/fibfestival', null, array['indie','pop','rock'], 'active', 'FIB duplicado referencial si se usa nombre completo.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, null, null, null, 'Benicàssim', 'Castellón', 'Comunitat Valenciana', 40.055, 0.064, 40000, 'https://fiberfib.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 85, 'media', now()
from public.festivals where slug = 'festival-internacional-de-benicassim'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://fiberfib.com', 'media', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'festival-internacional-de-benicassim';


insert into public.festivals (name, slug, official_website, instagram_url, ticket_url, main_genres, status, notes)
values ('Festival Far Valencia', 'festival-far-valencia', 'https://festivalfar.com', 'https://instagram.com/festivalfar', null, array['pop','rock','latino'], 'active', 'Marina Norte Valencia.')
on conflict (slug) do update set
  official_website = coalesce(excluded.official_website, public.festivals.official_website),
  instagram_url = coalesce(excluded.instagram_url, public.festivals.instagram_url),
  ticket_url = coalesce(excluded.ticket_url, public.festivals.ticket_url),
  main_genres = excluded.main_genres,
  notes = coalesce(public.festivals.notes, excluded.notes);

insert into public.festival_editions (festival_id, year, start_date, end_date, venue_name, city, province, region, latitude, longitude, expected_attendance, attendance_source_url, sales_stage, lifecycle_stage, ticket_status, opportunity_score, data_confidence, last_checked_at)
select id, 2026, '2026-07-08', '2026-07-31', null, 'Valencia', 'Valencia', 'Comunitat Valenciana', 39.4699, -0.3763, 15000, 'https://festivalfar.com', 'Detectado', 'Pendiente de validar', 'Pendiente', 60, 'baja', now()
from public.festivals where slug = 'festival-far-valencia'
on conflict do nothing;

insert into public.sources (festival_id, source_type, url, confidence, extracted_data)
select id, 'seed público inicial', 'https://festivalfar.com', 'baja', jsonb_build_object('nota','Registro inicial curado; validar edición, tramo y asistencia antes de contactar')
from public.festivals where slug = 'festival-far-valencia';

commit;