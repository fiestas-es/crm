import type { FestivalOverview } from "@/lib/types";
import { stageTone } from "@/lib/utils";

function coordinateToPercent(latitude?: number | null, longitude?: number | null, index = 0) {
  // Bounding box aproximado Península + Baleares + Canarias compactadas visualmente.
  // Si no hay coordenadas reales, colocamos el punto en una zona de revisión.
  if (typeof latitude !== "number" || typeof longitude !== "number") {
    const fallback = [
      [18, 78], [24, 82], [30, 76], [36, 80], [42, 74], [48, 78]
    ];
    return fallback[index % fallback.length];
  }

  // Canarias: se compacta abajo a la izquierda para que también aparezca en el mapa.
  if (latitude < 30 && longitude < -10) {
    const left = 15 + (longitude + 18) * 3.2;
    const top = 80 - (latitude - 27) * 5;
    return [Math.max(8, Math.min(30, left)), Math.max(72, Math.min(90, top))];
  }

  const minLon = -9.8;
  const maxLon = 4.5;
  const minLat = 35.7;
  const maxLat = 43.9;
  const left = ((longitude - minLon) / (maxLon - minLon)) * 78 + 10;
  const top = (1 - (latitude - minLat) / (maxLat - minLat)) * 66 + 12;
  return [Math.max(7, Math.min(92, left)), Math.max(8, Math.min(86, top))];
}

export function FestivalMap({ festivals }: { festivals: FestivalOverview[] }) {
  return (
    <div className="spain-map" aria-label="Mapa de festivales de España">
      <div className="spain-outline" />
      <div className="map-grid-lines" />
      <div className="canary-label">Canarias</div>
      <div className="balearic-label">Baleares</div>
      {festivals.slice(0, 80).map((festival, index) => {
        const [left, top] = coordinateToPercent(festival.latitude, festival.longitude, index);
        const tone = stageTone(festival.sales_stage || festival.lifecycle_stage);
        return (
          <a
            key={festival.festival_id}
            className={`map-point ${tone}`}
            href={`/festivals/${festival.festival_id}`}
            style={{ left: `${left}%`, top: `${top}%` }}
            title={`${festival.name}${festival.city ? ` · ${festival.city}` : ""}`}
          >
            <span className="map-label">{festival.name}</span>
          </a>
        );
      })}
    </div>
  );
}
