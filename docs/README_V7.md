# Fiestas Radar v7

## Qué cambia

- Mapa visual nuevo con estética corporativa Fiestas.
- Puntos de festivales por latitud/longitud real, con fallback por ciudad/provincia.
- Filtros reales por comunidad/provincia, mes, tramo público, estado interno y orden.
- Pipeline editable: nuevo, pendiente, contactado, interesado, propuesta enviada, negociando, cerrado, rechazado y finalizado.
- Ficha de festival reforzada: datos públicos, precio aprox., asistencia, contactos, propuesta y estado interno.
- Radar semanal preparado para Vercel Cron y botón manual “Ejecutar radar ahora”.

## Instalación segura

1. Haz backup del repositorio actual desde GitHub: Code → Download ZIP.
2. Sube los archivos de este ZIP encima del repositorio, manteniendo las mismas carpetas.
3. No borres `.env`, no borres Supabase, no borres Vercel.
4. En Supabase SQL Editor ejecuta `supabase/v7_operational_upgrade.sql`.
5. Opcional: ejecuta `supabase/v7_candidate_festivals_review.sql` si quieres añadir candidatos pendientes de validar.
6. En Vercel comprueba estas variables:
   - POSTGRES_URL
   - CRON_SECRET
   - TICKETMASTER_API_KEY, si quieres radar automático con Ticketmaster.
7. Haz commit en `main` y espera deploy.

## Puesta en marcha del radar

- Manual: entra en `/radar` y pulsa “Ejecutar radar ahora”.
- Automático: `vercel.json` programa `/api/radar/run` los lunes a las 07:00 UTC.
- Logs: Vercel → Project → Logs, filtrando por `/api/radar/run`.

## Seguridad

Si defines `CRON_SECRET`, la ruta acepta:

- Vercel Cron oficial.
- Header `Authorization: Bearer TU_SECRET`.
- `?secret=TU_SECRET` para pruebas manuales.

## No tocar si ya funciona

- No cambiar POSTGRES_URL.
- No borrar el proyecto de Supabase.
- No borrar el proyecto de Vercel.
- No borrar el repositorio GitHub.

