import type { FestivalOverview } from "@/lib/types";
import { StageBadge } from "./StageBadge";

const columns = [
  { key: "detectado", title: "Detectado" },
  { key: "venta", title: "Venta activa" },
  { key: "urgente", title: "Urgente" },
  { key: "propuesta", title: "Propuesta" },
  { key: "post", title: "Post-evento" }
];

function bucket(festival: FestivalOverview) {
  const value = `${festival.lifecycle_stage || ""} ${festival.sales_stage || ""}`.toLowerCase();
  if (value.includes("último") || value.includes("alta")) return "urgente";
  if (value.includes("propuesta") || value.includes("negoci")) return "propuesta";
  if (value.includes("post") || value.includes("recontactar")) return "post";
  if (value.includes("venta") || value.includes("tramo")) return "venta";
  return "detectado";
}

export function PipelineBoard({ festivals }: { festivals: FestivalOverview[] }) {
  return (
    <div className="pipeline">
      {columns.map((column) => {
        const items = festivals.filter((festival) => bucket(festival) === column.key).slice(0, 5);
        return (
          <section key={column.key} className="pipeline-column">
            <h3>{column.title} · {items.length}</h3>
            {items.map((festival) => (
              <div key={festival.festival_id} className="pipeline-item">
                <strong>{festival.name}</strong>
                <span className="soft">{festival.city || "Sin localidad"}</span>
                <div style={{ marginTop: 10 }}><StageBadge stage={festival.sales_stage || festival.lifecycle_stage} /></div>
              </div>
            ))}
          </section>
        );
      })}
    </div>
  );
}
