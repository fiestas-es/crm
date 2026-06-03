export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";
import { FestivalFilters } from "@/components/FestivalFilters";
import { AddFestivalForm } from "@/components/AddFestivalForm";
import { getFestivals } from "@/lib/data";

export default async function FestivalsPage() {
  const festivals = await getFestivals();

  return (
    <Shell>
      <div className="topbar hero-v7">
        <div>
          <p className="eyebrow">Base maestra</p>
          <h1>Festivales de España</h1>
          <p className="muted">Listado visual con scoring, tramos, fechas, ciudad, precios, asistencia y estado comercial.</p>
        </div>
      </div>

      <FestivalFilters festivals={festivals} />

      <section className="card add-festival-card-v7" id="nuevo">
        <p className="eyebrow">Nuevo festival</p>
        <h2>Añadir oportunidad manual</h2>
        <p className="muted">Útil para meter rápido un festival detectado por Instagram, prensa, contacto directo o ticketera.</p>
        <AddFestivalForm />
      </section>
    </Shell>
  );
}
