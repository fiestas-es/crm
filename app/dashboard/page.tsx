export const dynamic = "force-dynamic";
export const revalidate = 0;

import Link from "next/link";
import { Shell } from "@/components/Shell";
import { StatCard } from "@/components/StatCard";
import { FestivalFilters } from "@/components/FestivalFilters";
import { SpainFestivalMap } from "@/components/SpainFestivalMap";
import { EditablePipelineBoard } from "@/components/EditablePipelineBoard";
import { getDashboardData } from "@/lib/data";

export default async function DashboardPage() {
  const { festivals, alerts, stats } = await getDashboardData();
  const topFestivals = festivals.slice(0, 9);

  return (
    <Shell>
      <div className="topbar hero-v7">
        <div>
          <p className="eyebrow">Radar comercial</p>
          <h1>Festivales, contactos y oportunidades en un solo sitio.</h1>
          <p className="muted">Vista rápida para decidir a qué festivales contactar, cuándo y con qué propuesta.</p>
        </div>
        <div className="actions">
          <Link className="btn" href="/radar">Ver radar semanal</Link>
          <Link className="btn primary" href="/festivals#nuevo">Añadir festival</Link>
        </div>
      </div>

      <section className="grid stats">
        <StatCard label="Festivales registrados" value={stats.totalFestivals} delta="Base activa" />
        <StatCard label="Oportunidades calientes" value={stats.hot} delta="Score ≥ 80" />
        <StatCard label="Contactos guardados" value={stats.withContacts} delta="CRM interno" />
        <StatCard label="Alertas abiertas" value={stats.alerts} delta="Radar semanal" />
      </section>

      <section className="grid two dashboard-grid-v7">
        <div className="card card-map-v7">
          <div className="section-head-v7">
            <div>
              <p className="eyebrow">Mapa visual</p>
              <h2>España festivalera</h2>
            </div>
            <span className="badge green">Coordenadas reales</span>
          </div>
          <SpainFestivalMap festivals={festivals} />
        </div>

        <div className="card alerts-v7">
          <p className="eyebrow">Alertas</p>
          <h2>Cambios que requieren acción</h2>
          <div className="alert-list-v7">
            {alerts.slice(0, 6).map((alert) => (
              <article className="alert-card-v7" key={alert.id}>
                <span className={`badge ${alert.severity === "high" ? "red" : "orange"}`}>{alert.severity}</span>
                <h3>{alert.title}</h3>
                <p className="muted">{alert.festival_name ? `${alert.festival_name} · ` : ""}{alert.description}</p>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="priority-v7">
        <p className="eyebrow">Prioridad</p>
        <h2>Oportunidades calientes</h2>
        <FestivalFilters festivals={topFestivals} />
      </section>

      <section className="card pipeline-card-v7">
        <p className="eyebrow">Pipeline</p>
        <h2>Estado comercial editable</h2>
        <EditablePipelineBoard festivals={festivals} />
      </section>
    </Shell>
  );
}
