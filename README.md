# Fiestas Radar v6 — diagnóstico Supabase/Vercel

Versión corregida para que Vercel/Next no deje páginas cacheadas después de actualizar Supabase.

Cambios clave:
- Páginas de dashboard/festivales/contactos/propuestas/radar marcadas como dinámicas.
- `noStore()` en las consultas a Supabase.
- Endpoint de comprobación ampliado: `/api/debug/counts` muestra variables enmascaradas y prueba fetch directo.
- Mapa SVG mejorado de España y seed público de 86 festivales candidatos.

# Fiestas Radar

Aplicación interna para @fiestas_es: CRM visual de festivales de España, contactos, tramos de venta, radar semanal y generador de propuestas comerciales.

## Qué incluye

- Dashboard interno protegido por contraseña.
- Base de datos Supabase/Postgres.
- Fichas de festivales y ediciones.
- Contactos responsables por festival.
- Pipeline comercial.
- Alertas semanales.
- Generador de propuestas por email, Instagram, WhatsApp o llamada.
- Script de importación CSV.
- Job semanal preparado para Ticketmaster Discovery API y para conectores propios.

## Stack

- Next.js App Router
- TypeScript
- Supabase Postgres
- Supabase Service Role en servidor
- OpenAI API para propuestas
- Vercel para despliegue

## Puesta en marcha local

```bash
cp .env.example .env.local
npm install
npm run dev
```

Abre `http://localhost:3000`.

## Configurar Supabase

1. Crea un proyecto en Supabase.
2. Abre SQL Editor.
3. Ejecuta `supabase/migrations/0001_initial_schema.sql`.
4. Ejecuta `supabase/seed.sql` si quieres datos demo.
5. Copia estas claves a `.env.local` y después a Vercel:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`

## Subir a Vercel

1. Sube este repositorio a GitHub.
2. Entra en Vercel.
3. New Project → Import Git Repository.
4. Añade las variables de entorno de `.env.example`.
5. Deploy.

## Job semanal

En Vercel crea un Cron Job apuntando a:

```text
/api/radar/run
```

Cabecera requerida:

```text
Authorization: Bearer TU_CRON_SECRET
```

También puedes ejecutarlo manualmente:

```bash
npm run radar:weekly
```

## Importar festivales desde CSV

Edita `data/import_template.csv` y ejecuta:

```bash
npm run import:csv -- data/import_template.csv
```

## Seguridad

- La app está protegida por contraseña con cookie HTTP-only.
- La clave `SUPABASE_SERVICE_ROLE_KEY` solo se usa en servidor.
- No expongas nunca `SUPABASE_SERVICE_ROLE_KEY` en el navegador.
- Para producción avanzada, sustituye el login simple por Supabase Auth con usuarios nominales.
