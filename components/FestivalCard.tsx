import Link from "next/link";
import type { FestivalOverview } from "@/lib/types";
import { formatNumber, formatRange } from "@/lib/utils";
import { StageBadge } from "./StageBadge";

export function FestivalCard({ festival }: { festival: FestivalOverview }) {
  const score = festival.opportunity_score || 0;
  return (
    <Link className="card festival-card" href={`/festivals/${festival.festival_id}`}>
      <div className="card-top">
        <div>
          <h3 className="card-title">{festival.name}</h3>
          <div className="card-meta">
            {festival.city || "Localidad pendiente"} · {festival.province || "Provincia pendiente"}<br />
            {formatRange(festival.start_date, festival.end_date)}
          </div>
        </div>
        <div className="score-ring" style={{ "--score": score } as React.CSSProperties}>
          <div className="score-inner">{score}</div>
        </div>
      </div>

      <div className="actions">
        <StageBadge stage={festival.sales_stage || festival.lifecycle_stage} />
        {festival.data_confidence ? <span className="badge">Confianza {festival.data_confidence}</span> : null}
      </div>

      <div className="card-metrics">
        <div className="metric"><strong>{formatNumber(festival.expected_attendance)}</strong><span>Asistencia estimada</span></div>
        <div className="metric"><strong>{festival.ticket_status || "—"}</strong><span>Entradas</span></div>
        <div className="metric"><strong>{festival.main_genres?.slice(0, 2).join(", ") || "—"}</strong><span>Género</span></div>
      </div>
    </Link>
  );
}
