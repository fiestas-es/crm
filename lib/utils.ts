export function formatDate(value?: string | null) {
  if (!value) return "Sin fecha";
  return new Intl.DateTimeFormat("es-ES", { day: "2-digit", month: "short", year: "numeric" }).format(new Date(value));
}

export function formatRange(start?: string | null, end?: string | null) {
  if (!start && !end) return "Fechas por confirmar";
  if (start && !end) return formatDate(start);
  if (!start && end) return formatDate(end);
  return `${formatDate(start)} → ${formatDate(end)}`;
}

export function formatNumber(value?: number | null) {
  if (value === null || value === undefined) return "—";
  return new Intl.NumberFormat("es-ES").format(value);
}

export function slugify(input: string) {
  return input
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)+/g, "");
}

export function stageTone(stage?: string | null) {
  const s = (stage || "").toLowerCase();
  if (s.includes("último") || s.includes("sold") || s.includes("agot")) return "red";
  if (s.includes("tramo 2") || s.includes("avanz") || s.includes("alta")) return "orange";
  if (s.includes("tramo 1") || s.includes("venta")) return "green";
  if (s.includes("fecha") || s.includes("cartel") || s.includes("pre")) return "blue";
  return "purple";
}

export function channelLabel(channel: string) {
  const labels: Record<string, string> = {
    email: "Email",
    instagram: "Instagram DM",
    whatsapp: "WhatsApp",
    call: "Llamada"
  };
  return labels[channel] || channel;
}
