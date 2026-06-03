import type { FestivalOverview } from "@/lib/types";
import { stageTone } from "@/lib/utils";

function coordinateToPercent(latitude?: number | null, longitude?: number | null, index = 0) {
  // Proyección visual aproximada sobre el SVG de España.
  if (typeof latitude !== "number" || typeof longitude !== "number") {
    const fallback = [
      [18, 78], [24, 82], [30, 76], [36, 80], [42, 74], [48, 78]
    ];
    return fallback[index % fallback.length];
  }

  // Canarias compactadas abajo a la izquierda.
  if (latitude < 30 && longitude < -10) {
    const left = 10 + (longitude + 18) * 3.2;
    const top = 86 - (latitude - 27) * 5;
    return [Math.max(8, Math.min(30, left)), Math.max(73, Math.min(90, top))];
  }

  // Baleares.
  if (latitude >= 38 && latitude <= 40.5 && longitude >= 1.0 && longitude <= 4.6) {
    const left = 84 + (longitude - 1.0) * 3.2;
    const top = 46 - (latitude - 38.5) * 7;
    return [Math.max(82, Math.min(95, left)), Math.max(28, Math.min(54, top))];
  }

  const minLon = -9.8;
  const maxLon = 4.5;
  const minLat = 35.7;
  const maxLat = 43.9;
  const left = ((longitude - minLon) / (maxLon - minLon)) * 74 + 10;
  const top = (1 - (latitude - minLat) / (maxLat - minLat)) * 61 + 14;
  return [Math.max(7, Math.min(92, left)), Math.max(8, Math.min(86, top))];
}

export function FestivalMap({ festivals }: { festivals: FestivalOverview[] }) {
  return (
    <div className="spain-map" aria-label="Mapa de festivales de España">
      <svg className="spain-svg" viewBox="0 0 100 70" role="img" aria-label="Silueta de España">
        <defs>
          <linearGradient id="spainFill" x1="0" x2="1" y1="0" y2="1">
            <stop offset="0%" stopColor="rgba(255,255,255,.16)" />
            <stop offset="100%" stopColor="rgba(255,255,255,.045)" />
          </linearGradient>
          <filter id="mapGlow" x="-20%" y="-20%" width="140%" height="140%">
            <feDropShadow dx="0" dy="0" stdDeviation="2" floodColor="rgba(0,245,184,.18)" />
          </filter>
        </defs>
        <path
          className="spain-mainland"
          filter="url(#mapGlow)"
          d="M13.3 28.8 L18.9 19.2 L31.4 13.9 L45.7 11.5 L61.7 13.8 L75.6 17.6 L83.6 25.3 L86.8 35.4 L82.2 46.1 L72.2 50.6 L62.8 57.4 L47.2 61.3 L31.8 58.9 L20.9 52.2 L15.6 42.2 L9.6 34.1 Z"
        />
        <path className="spain-border" d="M18.9 19.2 L23.9 18.1 L29.4 15.0 M31.8 58.9 L36.8 56.2 L45.6 55.8 M61.7 13.8 L65.4 17.3 L73.4 17.7" />
        <ellipse className="island" cx="91.5" cy="37.2" rx="2.6" ry="1.2" />
        <ellipse className="island" cx="95.2" cy="39.2" rx="1.3" ry=".8" />
        <ellipse className="island" cx="88.6" cy="41.2" rx="1.1" ry=".7" />
        <ellipse className="island" cx="13" cy="63" rx="1.5" ry=".8" />
        <ellipse className="island" cx="17" cy="62" rx="1.3" ry=".7" />
        <ellipse className="island" cx="21" cy="63.3" rx="1.4" ry=".7" />
        <ellipse className="island" cx="25" cy="61.8" rx="1.2" ry=".7" />
        <text x="84" y="47" className="map-geo-label">BALEARES</text>
        <text x="9" y="68" className="map-geo-label">CANARIAS</text>
      </svg>
      <div className="map-grid-lines" />
      {festivals.slice(0, 120).map((festival, index) => {
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
