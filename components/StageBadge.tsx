import { stageTone } from "@/lib/utils";

export function StageBadge({ stage }: { stage?: string | null }) {
  const label = stage || "Sin tramo";
  return <span className={`badge ${stageTone(stage)}`}>{label}</span>;
}
