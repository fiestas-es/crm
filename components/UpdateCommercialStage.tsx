"use client";

import { useState } from "react";
import type { CommercialStage, FestivalOverview } from "@/lib/types";

const stages: Array<{ key: CommercialStage; label: string }> = [
  { key: "nuevo", label: "Nuevo" },
  { key: "pendiente_revisar", label: "Pendiente de revisar" },
  { key: "contactado", label: "Contactado" },
  { key: "interesado", label: "Interesado" },
  { key: "propuesta_enviada", label: "Propuesta enviada" },
  { key: "negociando", label: "Negociando" },
  { key: "cerrado", label: "Cerrado" },
  { key: "rechazado", label: "Rechazado" },
  { key: "finalizado", label: "Finalizado" }
];

export function UpdateCommercialStage({ festival }: { festival: FestivalOverview }) {
  const [value, setValue] = useState((festival.commercial_stage || "nuevo") as CommercialStage);
  const [state, setState] = useState<"idle" | "saving" | "saved" | "error">("idle");

  async function save(next: CommercialStage) {
    setValue(next);
    setState("saving");
    const id = festival.edition_id || festival.festival_id;
    const response = await fetch(`/api/festivals/${id}/commercial-stage`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ commercial_stage: next })
    });
    setState(response.ok ? "saved" : "error");
  }

  return (
    <div className="card stage-editor-v7">
      <p className="eyebrow">CRM interno</p>
      <h2>Estado del equipo</h2>
      <p className="muted">Este estado es vuestro pipeline interno. No cambia el tramo público detectado.</p>
      <select className="select" value={value} onChange={(event) => save(event.target.value as CommercialStage)}>
        {stages.map((stage) => <option key={stage.key} value={stage.key}>{stage.label}</option>)}
      </select>
      <p className="soft stage-status-v7">
        {state === "saving" ? "Guardando..." : state === "saved" ? "Guardado" : state === "error" ? "No se pudo guardar" : "Listo para actualizar"}
      </p>
    </div>
  );
}
