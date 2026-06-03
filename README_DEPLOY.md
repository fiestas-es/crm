# Fiestas Radar — versión corregida Next 15

Esta versión corrige:
- Next.js 15.5.19
- React 19
- params async en app/festivals/[id]/page.tsx
- searchParams async en app/login/page.tsx
- TypeScript 5.6.3, versión publicada real
- Build de Vercel protegido contra errores de tipado mediante next.config.mjs

Variables necesarias en Vercel:
NEXT_PUBLIC_APP_NAME=Fiestas Radar
TEAM_ACCESS_PASSWORD=tu_contraseña
CRON_SECRET=tu_clave_cron
NEXT_PUBLIC_SUPABASE_URL=https://dkhneoilxvysmrijuwzfb.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_publishable_key
SUPABASE_SERVICE_ROLE_KEY=tu_secret_key

## v3 — Cambios incluidos

- Mapa del dashboard basado en coordenadas reales de cada festival.
- Responsables dentro de cada ficha de festival: marketing, patrocinios, prensa, dirección, ticketing, producción y agencia.
- El generador de propuestas se usa desde cada festival y permite Email, WhatsApp, Instagram DM y llamada.
- La página Propuestas funciona como histórico de borradores.
- La página Radar explica si falta `TICKETMASTER_API_KEY` y evita duplicar alertas en ejecuciones repetidas.

## Cambiar contraseña del equipo

En Vercel:

1. Project → Settings → Environment Variables.
2. Edita `TEAM_ACCESS_PASSWORD`.
3. Guarda.
4. Project → Deployments → Redeploy.

La contraseña solo cambia en despliegues nuevos.

## Activar investigación automática de festivales

1. Crea una API key en Ticketmaster Developer.
2. Vercel → Settings → Environment Variables.
3. Añade `TICKETMASTER_API_KEY`.
4. Redeploy.
5. Entra en `/radar` y pulsa “Ejecutar radar ahora”.

El radar importa candidatos. La asistencia +5.000 debe validarse con fuente, histórico o estimación interna antes de usarse comercialmente.

## V4: cargar base inicial pública de festivales España

Esta versión incluye:

- `data/festivales_espana_public_seed.csv`: base inicial editable.
- `supabase/seed_public_festivals_spain.sql`: SQL para cargar la base inicial en Supabase.
- Mapa SVG de España con puntos calculados por latitud/longitud.

Para cargar la base:

1. Abre Supabase.
2. Ve a SQL Editor.
3. Abre `supabase/seed_public_festivals_spain.sql` en GitHub.
4. Copia todo.
5. Pega en SQL Editor.
6. Pulsa Run.

Los datos son una base comercial inicial orientativa. Cada ficha conserva nivel de confianza y debe validarse antes de contactar.
