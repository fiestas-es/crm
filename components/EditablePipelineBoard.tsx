"use client";

import { useMemo, useState } from "react";
import type { CommercialStage, FestivalOverview } from "@/lib/types";

const columns: Array<{ key: CommercialStage; title: string; hint: string }> = [
  { key: "nuevo", title: "Nuevo", hint: "Detectado, falta revisar" },
  { key: "pendiente_revisar", title: "Pendiente", hint: "Validar info/contacto" },
  { key: "contactado", title: "Contactado", hint: "Primer contacto enviado" },
  { key: "interesado", title: "Interesado", hint: "Hay respuesta positiva" },
  { key: "propuesta_enviada", title: "Propuesta", hint: "Borrador o propuesta enviada" },
  { key: "negociando", title: "Negociando", hint: "Condiciones abiertas" },
  { key: "cerrado", title: "Cerrado", hint: "Acuerdo confirmado" },
  { key: "rechazado", title: "Rechazado", hint: "No viable ahora" },
  { key: "finalizado", title: "Finalizado", hint: "Evento terminado/sin fecha" }
];

function normalizeStage(value?: string | null): CommercialStage {
  const stage = String(value || "nuevo") as CommercialStage;
  return columns.some((column) => column.key === stage) ? stage : "nuevo";
}

export function EditablePipelineBoard({ festivals }: { festivals: FestivalOverview[] }) {
  const [items, setItems] = useState(festivals);
  const [saving, setSaving] = useState<string | null>(null);

  const grouped = useMemo(() => {
    return columns.map((column) => ({
      ...column,
      items: items.filter((festival) => normalizeStage(festival.commercial_stage) === column.key)
    }));
  }, [items]);

  async function moveFestival(festival: FestivalOverview, stage: CommercialStage) {
    const id = festival.edition_id || festival.festival_id;
    setSaving(id);

    setItems((current) =>
      current.map((item) =>
        (item.edition_id || item.festival_id) === id ? { ...item, commercial_stage: stage } : item
      )
    );

    const response = await fetch(`/api/festivals/${id}/commercial-stage`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ commercial_stage: stage })
    });

    if (!response.ok) {
      alert("No se ha podido guardar el cambio. Recarga y revisa el estado.");
    }

    setSaving(null);
  }

  return (
    <div className="pipeline pipeline-v7">
      {grouped.map((column) => (
        <section className="pipeline-column" key={column.key}>
          <h3>{column.title} · {column.items.length}</h3>
          <p className="pipeline-hint">{column.hint}</p>
          <div className="pipeline-list-v7">
            {column.items.slice(0, 30).map((festival) => {
              const id = festival.edition_id || festival.festival_id;
              return (
                <article className="pipeline-item pipeline-item-v7" key={id}>
                  <strong>{festival.name}</strong>
                  <span>{festival.city || festival.province || "Sin ubicación"}</span>
                  <small>{festival.lifecycle_stage || festival.sales_stage || "Tramo pendiente"} · Score {festival.opportunity_score || 0}</small>
                  <select
                    className="select pipeline-select-v7"
                    value={normalizeStage(festival.commercial_stage)}
                    disabled={saving === id}
                    onChange={(event) => moveFestival(festival, event.target.value as CommercialStage)}
                  >
                    {columns.map((option) => (
                      <option key={option.key} value={option.key}>{option.title}</option>
                    ))}
                  </select>
                </article>
              );
            })}
          </div>
        </section>
      ))}
    </div>
  );
}
