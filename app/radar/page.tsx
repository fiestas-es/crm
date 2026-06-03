export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";
import { getRadarAlerts, getFestivals } from "@/lib/data";
import { formatDate } from "@/lib/utils";

export default async function RadarPage() {
  const [alerts, festivals] = await Promise.all([getRadarAlerts(), getFestivals()]);
  const hot = festivals.filter((f) => (f.opportunity_score || 0) >= 80);

  return (
    <Shell>
      <div className="topbar">
        <div>
          <p className="eyebrow">Actualización semanal</p>
          <h1>Radar de cambios</h1>
          <p className="muted">Busca nuevos festivales, detecta cambios y deja alertas para revisar. No sustituye la validación humana.</p>
        </div>
        <form action="/api/radar/run" method="post">
          <button className="btn primary" type="submit">Ejecutar radar ahora</button>
        </form>
      </div>

      <section className="card" style={{ marginBottom: 18 }}>
        <div className="card-top">
          <div>
            <p className="eyebrow">Estado del radar</p>
            <h2>Para que importe festivales reales necesitas una API key</h2>
            <p className="muted">Si al ejecutar ves “Sin TICKETMASTER_API_KEY o Supabase”, el sistema está funcionando, pero todavía no tiene fuente automática conectada.</p>
          </div>
          <span className="badge orange">Pendiente de fuente</span>
        </div>
        <div className="kv">
          <div><span>Fuente automática preparada</span><strong>Ticketmaster Discovery API</strong></div>
          <div><span>Filtro inicial</span><strong>España · música · festival</strong></div>
          <div><span>Resultado esperado</span><strong>Nuevos festivales + alertas de revisión</strong></div>
          <div><span>Asistencia +5.000</span><strong>Se valida con fuente/estimación, no se inventa</strong></div>
        </div>
      </section>

      <section className="grid two">
        <div className="card">
          <p className="eyebrow">Alertas abiertas</p>
          <h2>Revisión del equipo</h2>
          <div className="grid">
            {alerts.map((alert) => (
              <article key={alert.id} className="pipeline-item">
                <span className={`badge ${alert.severity === "high" ? "red" : alert.severity === "medium" ? "orange" : "blue"}`}>{alert.severity}</span>
                <h3 style={{ marginTop: 12 }}>{alert.title}</h3>
                <p className="muted">{alert.festival_name ? `${alert.festival_name} · ` : ""}{alert.description}</p>
                <p className="soft">{alert.created_at ? formatDate(alert.created_at) : ""}</p>
              </article>
            ))}
          </div>
        </div>

        <div className="card">
          <p className="eyebrow">Top prioridad</p>
          <h2>Contactar primero</h2>
          <div className="grid">
            {hot.slice(0, 8).map((festival) => (
              <article key={festival.festival_id} className="pipeline-item">
                <strong>{festival.name}</strong>
                <p className="muted">{festival.city || "—"} · {festival.sales_stage || festival.lifecycle_stage || "Sin estado"}</p>
                <a className="badge green" href={`/festivals/${festival.festival_id}`}>Abrir ficha · Score {festival.opportunity_score}</a>
              </article>
            ))}
          </div>
        </div>
      </section>
    </Shell>
  );
}
