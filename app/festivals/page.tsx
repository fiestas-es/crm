import { Shell } from "@/components/Shell";
import { FestivalCard } from "@/components/FestivalCard";
import { AddFestivalForm } from "@/components/AddFestivalForm";
import { getFestivals } from "@/lib/data";

export default async function FestivalsPage() {
  const festivals = await getFestivals();

  return (
    <Shell>
      <div className="topbar">
        <div>
          <p className="eyebrow">Base maestra</p>
          <h1>Festivales de España</h1>
          <p className="muted">Listado visual con scoring, tramos, fechas, ciudad y datos comerciales.</p>
        </div>
      </div>

      <div className="searchbar">
        <input className="input" placeholder="Buscar festival, ciudad, provincia..." />
        <select className="select" defaultValue=""><option value="">Comunidad</option></select>
        <select className="select" defaultValue=""><option value="">Mes</option></select>
        <select className="select" defaultValue=""><option value="">Tramo</option></select>
        <select className="select" defaultValue="score"><option value="score">Orden: prioridad</option></select>
      </div>

      <div className="grid three">
        {festivals.map((festival) => <FestivalCard key={festival.festival_id} festival={festival} />)}
      </div>

      <div style={{ marginTop: 26 }}>
        <AddFestivalForm />
      </div>
    </Shell>
  );
}
