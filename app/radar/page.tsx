export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";
import { RunRadarButton } from "@/components/RunRadarButton";
import { getRadarAlerts, getFestivals } from "@/lib/data";
import { formatDate } from "@/lib/utils";

export default async function RadarPage() {
  const [alerts, festivals] = await Promise.all([getRadarAlerts(), getFestivals()]);
  const hot = festivals.filter((f) => (f.opportunity_score || 0) >= 80);

  return (
    <Shell>
      <div className="topbar hero-v7">
        <div>
          <p className="eyebrow">Actualización semanal</p>
          <h1>Radar de cambios</h1>
          <p className="muted">Busca nuevos festivales, detecta cambios públicos y deja alertas para revisar. No envía mensajes automáticamente.</p>
        </div>
        <RunRadarButton />
      </div>

      <section className="grid three radar-status-v7">
        <div className="card">
          <p className="eyebrow">Fuente automática</p>
          <h2>Ticketmaster Discovery API</h2>
          <p className="muted">España · música · keyword festival/sound/live/fest. Se complementa con validación humana y fuentes oficiales.</p>
        </div>
        <div className="card">
          <p className="eyebrow">Resultado esperado</p>
          <h2>Nuevos festivales + alertas</h2>
          <p className="muted">Actualiza fechas, venue, ticket URL, precios cuando existan y crea alerta de revisión.</p>
        </div>
        <div className="card">
          <p className="eyebrow">Asistencia +5.000</p>
          <h2>Estimación, no invención</h2>
          <p className="muted">La asistencia se valida con fuentes públicas, histórico o manualmente desde la ficha.</p>
        </div>
      </section>

      <section className="grid two">
        <div className="card alerts-v7">
          <p className="eyebrow">Alertas abiertas</p>
          <h2>Revisión del equipo</h2>
          <div className="alert-list-v7">
            {alerts.map((alert) => (
              <article className="alert-card-v7" key={alert.id}>
                <span className={`badge ${alert.severity === "high" ? "red" : "orange"}`}>{alert.severity}</span>
                <h3>{alert.title}</h3>
                <p className="muted">{alert.festival_name ? `${alert.festival_name} · ` : ""}{alert.description}</p>
                <small className="soft">{alert.created_at ? formatDate(alert.created_at) : ""}</small>
              </article>
            ))}
          </div>
        </div>

        <div className="card">
          <p className="eyebrow">Top prioridad</p>
          <h2>Contactar primero</h2>
          <div className="hot-list-v7">
            {hot.slice(0, 14).map((festival) => (
              <a className="hot-row-v7" href={`/festivals/${festival.slug || festival.festival_id}`} key={festival.festival_id}>
                <strong>{festival.name}</strong>
                <span>{festival.city || "—"} · {festival.commercial_stage || festival.sales_stage || festival.lifecycle_stage || "Sin estado"}</span>
                <b>{festival.opportunity_score}</b>
              </a>
            ))}
          </div>
        </div>
      </section>
    </Shell>
  );
}
