import type { FestivalOverview } from "@/lib/types";
import { stageTone } from "@/lib/utils";

function position(index: number) {
  const coords = [
    [52, 41], [63, 62], [43, 23], [33, 56], [70, 42], [48, 70], [25, 35], [58, 28], [39, 75], [76, 68]
  ];
  return coords[index % coords.length];
}

export function FestivalMap({ festivals }: { festivals: FestivalOverview[] }) {
  return (
    <div className="map">
      {festivals.slice(0, 18).map((festival, index) => {
        const [left, top] = position(index);
        const tone = stageTone(festival.sales_stage || festival.lifecycle_stage);
        return (
          <div key={festival.festival_id} className={`map-point ${tone}`} style={{ left: `${left}%`, top: `${top}%` }}>
            <span className="map-label">{festival.name}</span>
          </div>
        );
      })}
    </div>
  );
}
