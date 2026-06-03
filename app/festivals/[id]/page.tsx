export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";
import { StageBadge } from "@/components/StageBadge";
import { ContactList } from "@/components/ContactList";
import { AddContactForm } from "@/components/AddContactForm";
import { ProposalGenerator } from "@/components/ProposalGenerator";
import { getContacts, getFestival } from "@/lib/data";
import { formatDate, formatNumber, formatRange } from "@/lib/utils";

type FestivalDetailPageProps = {
  params: Promise<{ id: string }>;
};

export default async function FestivalDetailPage({ params }: FestivalDetailPageProps) {
  const { id } = await params;
  const festival = await getFestival(id);
  const contacts = await getContacts(festival.festival_id);

  return (
    <Shell>
      <section className="detail-hero">
        <div className="card">
          <p className="eyebrow">Ficha festival</p>
          <h1 className="big-title">{festival.name}</h1>
          <p className="muted">{festival.city || "Localidad pendiente"} · {festival.province || "Provincia pendiente"} · {formatRange(festival.start_date, festival.end_date)}</p>
          <div className="actions">
            <StageBadge stage={festival.sales_stage || festival.lifecycle_stage} />
            <span className="badge green">Score {festival.opportunity_score || 0}/100</span>
            <span className="badge">Confianza {festival.data_confidence || "pendiente"}</span>
          </div>
        </div>
        <div className="card">
          <p className="eyebrow">Acción sugerida</p>
          <h2>{(festival.opportunity_score || 0) >= 80 ? "Contactar esta semana" : "Mantener en seguimiento"}</h2>
          <p className="muted">Primero añade o elige el responsable correcto. Después genera email, WhatsApp, DM de Instagram o guion de llamada.</p>
          <a className="btn primary" href="#propuesta">Generar propuesta</a>
        </div>
      </section>

      <section className="grid two" style={{ marginTop: 20 }}>
        <div className="card">
          <p className="eyebrow">Información</p>
          <h2>Datos principales</h2>
          <div className="kv">
            <div><span>Fechas</span><strong>{formatRange(festival.start_date, festival.end_date)}</strong></div>
            <div><span>Localidad</span><strong>{festival.city || "—"}</strong></div>
            <div><span>Recinto</span><strong>{festival.venue_name || "—"}</strong></div>
            <div><span>Asistencia media</span><strong>{formatNumber(festival.avg_attendance)}</strong></div>
            <div><span>Asistencia estimada</span><strong>{formatNumber(festival.expected_attendance)}</strong></div>
            <div><span>Última revisión</span><strong>{festival.last_checked_at ? formatDate(festival.last_checked_at) : "—"}</strong></div>
            <div><span>Web</span><strong>{festival.official_website ? <a href={festival.official_website} target="_blank">Abrir</a> : "—"}</strong></div>
            <div><span>Instagram</span><strong>{festival.instagram_url ? <a href={festival.instagram_url} target="_blank">Abrir</a> : "—"}</strong></div>
          </div>
        </div>

        <div className="card">
          <p className="eyebrow">Equipo interno del festival</p>
          <h2>Responsables asociados a esta ficha</h2>
          <ContactList contacts={contacts} />
        </div>
      </section>

      <section style={{ marginTop: 20 }} id="propuesta">
        <ProposalGenerator festival={festival} contacts={contacts} />
      </section>

      <section style={{ marginTop: 20 }}>
        <AddContactForm festivalId={festival.festival_id} />
      </section>
    </Shell>
  );
}
