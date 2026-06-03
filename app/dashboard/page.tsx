export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";
import { StatCard } from "@/components/StatCard";
import { FestivalCard } from "@/components/FestivalCard";
import { FestivalMap } from "@/components/FestivalMap";
import { PipelineBoard } from "@/components/PipelineBoard";
import { getDashboardData } from "@/lib/data";

export default async function DashboardPage() {
  const { festivals, alerts, stats } = await getDashboardData();
  const topFestivals = festivals.slice(0, 6);

  return (
    <Shell>
      <div className="topbar">
        <div>
          <p className="eyebrow">Radar comercial</p>
          <h1>Festivales, contactos y oportunidades en un solo sitio.</h1>
          <p className="muted">Vista rápida para decidir a qué festivales contactar, cuándo y con qué propuesta.</p>
        </div>
        <div className="actions">
          <a className="btn" href="/radar">Ver radar semanal</a>
          <a className="btn primary" href="/festivals">Añadir festival</a>
        </div>
      </div>

      <section className="grid stats">
        <StatCard label="Festivales registrados" value={stats.totalFestivals} delta="Base activa" />
        <StatCard label="Oportunidades calientes" value={stats.hot} delta="Score ≥ 80" />
        <StatCard label="Contactos guardados" value={stats.withContacts} delta="CRM interno" />
        <StatCard label="Alertas abiertas" value={stats.alerts} delta="Radar semanal" />
      </section>

      <section className="grid two" style={{ marginTop: 18 }}>
        <div className="card">
          <div className="card-top">
            <div>
              <p className="eyebrow">Mapa visual</p>
              <h2>España festivalera</h2>
            </div>
            <span className="badge green">Mapa real</span>
          </div>
          <FestivalMap festivals={festivals} />
        </div>

        <div className="card">
          <p className="eyebrow">Alertas</p>
          <h2>Cambios que requieren acción</h2>
          <div className="grid">
            {alerts.slice(0, 5).map((alert) => (
              <article className="pipeline-item" key={alert.id}>
                <span className={`badge ${alert.severity === "high" ? "red" : "orange"}`}>{alert.severity}</span>
                <h3 style={{ marginTop: 12 }}>{alert.title}</h3>
                <p className="muted">{alert.festival_name ? `${alert.festival_name} · ` : ""}{alert.description}</p>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section style={{ marginTop: 26 }}>
        <div className="topbar">
          <div>
            <p className="eyebrow">Prioridad</p>
            <h2>Oportunidades calientes</h2>
          </div>
        </div>
        <div className="grid three">
          {topFestivals.map((festival) => <FestivalCard key={festival.festival_id} festival={festival} />)}
        </div>
      </section>

      <section className="card" style={{ marginTop: 26 }}>
        <p className="eyebrow">Pipeline</p>
        <h2>Estado comercial</h2>
        <PipelineBoard festivals={festivals} />
      </section>
    </Shell>
  );
}
