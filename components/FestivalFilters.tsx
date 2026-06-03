"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import type { FestivalOverview } from "@/lib/types";

function fmtNumber(value?: number | null) {
  if (value === null || value === undefined) return "—";
  return new Intl.NumberFormat("es-ES").format(value);
}

function fmtDateRange(start?: string | null, end?: string | null) {
  if (!start && !end) return "Fechas por confirmar";
  const opts: Intl.DateTimeFormatOptions = { day: "2-digit", month: "short", year: "numeric" };
  const format = (value: string) => new Intl.DateTimeFormat("es-ES", opts).format(new Date(value));
  if (start && end) return `${format(start)} → ${format(end)}`;
  return format(start || end || "");
}

function monthFromDate(date?: string | null) {
  if (!date) return "sin_mes";
  const parsed = new Date(date);
  if (Number.isNaN(parsed.getTime())) return "sin_mes";
  return String(parsed.getMonth() + 1).padStart(2, "0");
}

const monthLabels: Record<string, string> = {
  "01": "Enero",
  "02": "Febrero",
  "03": "Marzo",
  "04": "Abril",
  "05": "Mayo",
  "06": "Junio",
  "07": "Julio",
  "08": "Agosto",
  "09": "Septiembre",
  "10": "Octubre",
  "11": "Noviembre",
  "12": "Diciembre",
  sin_mes: "Sin fecha"
};

export function FestivalFilters({ festivals }: { festivals: FestivalOverview[] }) {
  const [query, setQuery] = useState("");
  const [region, setRegion] = useState("all");
  const [month, setMonth] = useState("all");
  const [publicStage, setPublicStage] = useState("all");
  const [commercialStage, setCommercialStage] = useState("all");
  const [sort, setSort] = useState("score");

  const regions = useMemo(
    () => Array.from(new Set(festivals.map((f) => f.region || f.province).filter(Boolean))).sort() as string[],
    [festivals]
  );

  const publicStages = useMemo(
    () => Array.from(new Set(festivals.map((f) => f.lifecycle_stage || f.sales_stage).filter(Boolean))).sort() as string[],
    [festivals]
  );

  const commercialStages = useMemo(
    () => Array.from(new Set(festivals.map((f) => f.commercial_stage).filter(Boolean))).sort() as string[],
    [festivals]
  );

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();

    const result = festivals.filter((festival) => {
      const haystack = [festival.name, festival.city, festival.province, festival.region, festival.main_genres?.join(" ")]
        .filter(Boolean)
        .join(" ")
        .toLowerCase();

      const matchesQuery = !q || haystack.includes(q);
      const matchesRegion = region === "all" || festival.region === region || festival.province === region;
      const matchesMonth = month === "all" || monthFromDate(festival.start_date) === month;
      const matchesPublicStage =
        publicStage === "all" || festival.lifecycle_stage === publicStage || festival.sales_stage === publicStage;
      const matchesCommercialStage = commercialStage === "all" || festival.commercial_stage === commercialStage;

      return matchesQuery && matchesRegion && matchesMonth && matchesPublicStage && matchesCommercialStage;
    });

    return result.sort((a, b) => {
      if (sort === "attendance") return (b.expected_attendance || 0) - (a.expected_attendance || 0);
      if (sort === "date") return String(a.start_date || "9999").localeCompare(String(b.start_date || "9999"));
      if (sort === "name") return a.name.localeCompare(b.name);
      return (b.opportunity_score || 0) - (a.opportunity_score || 0);
    });
  }, [festivals, query, region, month, publicStage, commercialStage, sort]);

  return (
    <section className="festival-browser-v7">
      <div className="searchbar searchbar-v7">
        <input
          className="input"
          placeholder="Buscar festival, ciudad, provincia, género..."
          value={query}
          onChange={(event) => setQuery(event.target.value)}
        />
        <select className="select" value={region} onChange={(event) => setRegion(event.target.value)}>
          <option value="all">Comunidad / provincia</option>
          {regions.map((item) => (
            <option key={item} value={item}>{item}</option>
          ))}
        </select>
        <select className="select" value={month} onChange={(event) => setMonth(event.target.value)}>
          <option value="all">Mes</option>
          {Object.entries(monthLabels).map(([key, value]) => (
            <option key={key} value={key}>{value}</option>
          ))}
        </select>
        <select className="select" value={publicStage} onChange={(event) => setPublicStage(event.target.value)}>
          <option value="all">Tramo público</option>
          {publicStages.map((item) => (
            <option key={item} value={item}>{item}</option>
          ))}
        </select>
        <select className="select" value={commercialStage} onChange={(event) => setCommercialStage(event.target.value)}>
          <option value="all">Estado interno</option>
          {commercialStages.map((item) => (
            <option key={item} value={item}>{item}</option>
          ))}
        </select>
        <select className="select" value={sort} onChange={(event) => setSort(event.target.value)}>
          <option value="score">Orden: prioridad</option>
          <option value="attendance">Orden: asistencia</option>
          <option value="date">Orden: fecha</option>
          <option value="name">Orden: nombre</option>
        </select>
      </div>

      <div className="result-count-v7">
        <strong>{filtered.length}</strong> festivales visibles de {festivals.length}
      </div>

      <div className="grid three festival-grid-v7">
        {filtered.map((festival) => {
          const score = festival.opportunity_score || 0;
          return (
            <Link
              href={`/festivals/${festival.slug || festival.festival_id}`}
              className="card festival-card festival-card-v7"
              key={`${festival.festival_id}-${festival.edition_id || "edition"}`}
            >
              <div className="card-top">
                <div>
                  <h3 className="card-title">{festival.name}</h3>
                  <p className="card-meta">
                    {festival.city || "Localidad pendiente"} · {festival.province || festival.region || "Provincia pendiente"}
                    <br />
                    {fmtDateRange(festival.start_date, festival.end_date)}
                  </p>
                </div>
                <div className="score-ring" style={{ "--score": score } as React.CSSProperties}>
                  <span className="score-inner">{score}</span>
                </div>
              </div>

              <div className="stage-row-v7">
                <span className="badge purple">{festival.lifecycle_stage || festival.sales_stage || "Detectado"}</span>
                <span className="badge green">{festival.commercial_stage || "nuevo"}</span>
              </div>

              <div className="card-metrics">
                <div className="metric"><strong>{fmtNumber(festival.expected_attendance || festival.avg_attendance)}</strong><span>Asistencia</span></div>
                <div className="metric"><strong>{festival.ticket_min_price ? `desde ${festival.ticket_min_price}€` : festival.ticket_status || "—"}</strong><span>Entrada</span></div>
                <div className="metric"><strong>{festival.main_genres?.slice(0, 2).join(", ") || "—"}</strong><span>Género</span></div>
              </div>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
