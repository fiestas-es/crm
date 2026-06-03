import Link from "next/link";
import type { FestivalOverview } from "@/lib/types";
import { projectSpainPoint, resolveFestivalCoordinates, scoreColor } from "@/lib/map";

type Props = {
  festivals: FestivalOverview[];
  limit?: number;
};

export function SpainFestivalMap({ festivals, limit = 220 }: Props) {
  const points = festivals
    .map((festival) => {
      const coord = resolveFestivalCoordinates(festival);
      if (!coord) return null;
      const point = projectSpainPoint(coord);
      return { festival, ...point };
    })
    .filter(Boolean)
    .slice(0, limit) as Array<{
      festival: FestivalOverview;
      x: number;
      y: number;
      zone: string;
    }>;

  return (
    <div className="spain-map-v7" aria-label="Mapa de festivales de España">
      <div className="map-ambient" />
      <svg className="spain-svg-v7" viewBox="0 0 1000 680" role="img" aria-hidden="true">
        <defs>
          <linearGradient id="fiestasMapFill" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#111A46" />
            <stop offset="50%" stopColor="#121633" />
            <stop offset="100%" stopColor="#060B25" />
          </linearGradient>
          <linearGradient id="fiestasStroke" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#ff34ff" stopOpacity="0.72" />
            <stop offset="100%" stopColor="#00f0bf" stopOpacity="0.56" />
          </linearGradient>
          <filter id="mapGlow" x="-20%" y="-20%" width="140%" height="140%">
            <feGaussianBlur stdDeviation="5" result="blur" />
            <feMerge>
              <feMergeNode in="blur" />
              <feMergeNode in="SourceGraphic" />
            </feMerge>
          </filter>
        </defs>

        <path
          className="map-region-main"
          d="M125 148 L172 95 L236 70 L284 37 L339 57 L420 49 L496 63 L545 47 L576 83 L650 80 L707 116 L759 118 L817 163 L880 178 L902 226 L866 286 L840 351 L864 406 L827 474 L760 504 L715 560 L626 584 L564 619 L466 608 L391 632 L303 603 L257 548 L198 523 L164 462 L113 412 L137 351 L114 299 L157 245 Z"
        />
        <path className="map-region-line" d="M236 70 L310 150 L334 232 L288 312 L208 338 L164 462" />
        <path className="map-region-line" d="M339 57 L365 144 L448 161 L492 235 L455 326 L334 332 L288 312" />
        <path className="map-region-line" d="M496 63 L486 151 L545 220 L650 222 L707 116" />
        <path className="map-region-line" d="M650 222 L620 322 L663 397 L760 504" />
        <path className="map-region-line" d="M455 326 L520 418 L490 516 L391 632" />
        <path className="map-region-line" d="M520 418 L626 584" />
        <path className="map-region-line" d="M545 220 L492 235" />
        <path className="map-region-line" d="M310 150 L420 49" />
        <path className="map-region-line" d="M650 80 L650 222" />

        <g className="map-islands" filter="url(#mapGlow)">
          <ellipse cx="885" cy="375" rx="24" ry="8" />
          <ellipse cx="930" cy="395" rx="17" ry="6" />
          <ellipse cx="853" cy="421" rx="9" ry="5" />
          <ellipse cx="900" cy="435" rx="12" ry="5" />
          <path d="M115 580 l33 9 l-7 18 l-41 4 l-26 -16 z" />
          <path d="M178 606 l42 -10 l15 22 l-24 28 l-45 -14 z" />
          <path d="M262 606 l54 -28 l20 31 l-26 49 l-59 2 z" />
          <path d="M355 600 l34 -15 l10 18 l-22 28 l-33 -5 z" />
          <circle cx="442" cy="606" r="8" />
          <circle cx="492" cy="622" r="6" />
        </g>

        <text x="310" y="203" className="map-community-label">MADRID</text>
        <text x="708" y="300" className="map-community-label">VALENCIA</text>
        <text x="620" y="450" className="map-community-label">MURCIA</text>
        <text x="358" y="520" className="map-community-label">ANDALUCÍA</text>
        <text x="760" y="210" className="map-community-label">CATALUÑA</text>
        <text x="150" y="140" className="map-community-label">GALICIA</text>
        <text x="132" y="640" className="map-community-label">CANARIAS</text>
        <text x="850" y="470" className="map-community-label">BALEARES</text>
      </svg>

      <div className="map-points-layer">
        {points.map(({ festival, x, y }) => {
          const score = festival.opportunity_score || 0;
          const href = `/festivals/${festival.slug || festival.festival_id}`;
          return (
            <Link
              key={`${festival.festival_id}-${festival.edition_id || "edition"}`}
              href={href}
              className={`map-dot ${scoreColor(score)}`}
              style={{ left: `${x}%`, top: `${y}%` }}
              title={`${festival.name} · ${festival.city || "Sin ciudad"} · Score ${score}`}
            >
              <span className="map-dot-core" />
              <span className="map-tooltip">
                <strong>{festival.name}</strong>
                <small>{festival.city || festival.province || "Ubicación pendiente"} · Score {score}</small>
              </span>
            </Link>
          );
        })}
      </div>

      <div className="map-legend-v7">
        <span><i className="legend-hot" /> Score alto</span>
        <span><i className="legend-warm" /> Revisar</span>
        <span><i className="legend-cool" /> Seguimiento</span>
      </div>
    </div>
  );
}
