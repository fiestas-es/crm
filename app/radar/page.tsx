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
          <p className="muted">Cambios de tramo, festivales nuevos, oportunidades calientes y datos a revisar.</p>
        </div>
        <form action="/api/radar/run" method="post">
          <button className="btn primary" type="submit">Ejecutar radar ahora</button>
        </form>
      </div>

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
                <span className="badge green">Score {festival.opportunity_score}</span>
              </article>
            ))}
          </div>
        </div>
      </section>
    </Shell>
  );
}
