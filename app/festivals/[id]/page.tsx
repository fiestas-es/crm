export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";
import { ContactList } from "@/components/ContactList";
import { AddContactForm } from "@/components/AddContactForm";
import { ProposalGenerator } from "@/components/ProposalGenerator";
import { UpdateCommercialStage } from "@/components/UpdateCommercialStage";
import { SpainFestivalMap } from "@/components/SpainFestivalMap";
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
      <div className="detail-hero detail-hero-v7">
        <section className="card detail-main-v7">
          <p className="eyebrow">Ficha festival</p>
          <h1 className="big-title">{festival.name}</h1>
          <p className="muted">
            {festival.city || "Localidad pendiente"} · {festival.province || festival.region || "Provincia pendiente"} · {formatRange(festival.start_date, festival.end_date)}
          </p>
          <div className="actions">
            <span className="badge green">Score {festival.opportunity_score || 0}/100</span>
            <span className="badge purple">{festival.lifecycle_stage || festival.sales_stage || "Tramo pendiente"}</span>
            <span className="badge blue">{festival.commercial_stage || "nuevo"}</span>
            <span className="badge">Confianza {festival.data_confidence || "pendiente"}</span>
          </div>
        </section>
        <UpdateCommercialStage festival={festival} />
      </div>

      <section className="grid two detail-grid-v7">
        <div className="card">
          <p className="eyebrow">Información</p>
          <h2>Datos principales</h2>
          <div className="kv">
            <div><span>Fechas</span><strong>{formatRange(festival.start_date, festival.end_date)}</strong></div>
            <div><span>Localidad</span><strong>{festival.city || "—"}</strong></div>
            <div><span>Provincia</span><strong>{festival.province || "—"}</strong></div>
            <div><span>Comunidad</span><strong>{festival.region || "—"}</strong></div>
            <div><span>Recinto</span><strong>{festival.venue_name || "—"}</strong></div>
            <div><span>Asistencia media</span><strong>{formatNumber(festival.avg_attendance)}</strong></div>
            <div><span>Asistencia estimada</span><strong>{formatNumber(festival.expected_attendance)}</strong></div>
            <div><span>Precio aprox.</span><strong>{festival.ticket_min_price ? `${festival.ticket_min_price}€${festival.ticket_max_price ? ` - ${festival.ticket_max_price}€` : ""}` : "—"}</strong></div>
            <div><span>Última revisión</span><strong>{festival.last_checked_at ? formatDate(festival.last_checked_at) : "—"}</strong></div>
            <div><span>Web</span><strong>{festival.official_website ? <a href={festival.official_website} target="_blank">Abrir</a> : "—"}</strong></div>
            <div><span>Instagram</span><strong>{festival.instagram_url ? <a href={festival.instagram_url} target="_blank">Abrir</a> : "—"}</strong></div>
            <div><span>Entradas</span><strong>{festival.ticket_url ? <a href={festival.ticket_url} target="_blank">Abrir</a> : festival.ticket_status || "—"}</strong></div>
          </div>
        </div>
        <div className="card card-map-v7 compact-map-v7">
          <p className="eyebrow">Ubicación</p>
          <h2>Mapa</h2>
          <SpainFestivalMap festivals={[festival]} limit={1} />
        </div>
      </section>

      <section className="grid two detail-grid-v7">
        <div className="card">
          <p className="eyebrow">Equipo interno del festival</p>
          <h2>Responsables asociados a esta ficha</h2>
          <ContactList contacts={contacts} />
          <AddContactForm festivalId={festival.festival_id} />
        </div>
        <ProposalGenerator festival={festival} contacts={contacts} />
      </section>
    </Shell>
  );
}
