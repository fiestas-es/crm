import type { FestivalOverview } from "./types";

export function calculateOpportunityScore(festival: Partial<FestivalOverview>) {
  let score = 0;

  const attendance = festival.expected_attendance || festival.avg_attendance || 0;
  if (attendance >= 80000) score += 25;
  else if (attendance >= 40000) score += 20;
  else if (attendance >= 15000) score += 12;
  else if (attendance > 0) score += 6;

  const stage = (festival.sales_stage || festival.lifecycle_stage || "").toLowerCase();
  if (stage.includes("tramo 1") || stage.includes("tramo 2")) score += 25;
  else if (stage.includes("venta")) score += 20;
  else if (stage.includes("cartel") || stage.includes("fecha")) score += 14;
  else if (stage.includes("último")) score += 10;
  else if (stage.includes("post")) score += 8;

  if (festival.instagram_url) score += 8;
  if (festival.official_website) score += 8;
  if (festival.start_date) {
    const days = (new Date(festival.start_date).getTime() - Date.now()) / (1000 * 60 * 60 * 24);
    if (days >= 30 && days <= 140) score += 22;
    else if (days > 140 && days <= 260) score += 12;
    else if (days > 0) score += 8;
  }

  return Math.max(0, Math.min(100, Math.round(score)));
}
