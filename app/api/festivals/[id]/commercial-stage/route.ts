import { NextResponse } from "next/server";
import { getSql } from "@/lib/postgres";
import type { CommercialStage } from "@/lib/types";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

const allowedStages: CommercialStage[] = [
  "nuevo",
  "pendiente_revisar",
  "contactado",
  "interesado",
  "propuesta_enviada",
  "negociando",
  "cerrado",
  "rechazado",
  "finalizado"
];

type Context = { params: Promise<{ id: string }> };

export async function PATCH(request: Request, context: Context) {
  const { id } = await context.params;
  const body = await request.json().catch(() => ({}));
  const stage = body.commercial_stage as CommercialStage;

  if (!allowedStages.includes(stage)) {
    return NextResponse.json({ error: "Estado comercial no válido" }, { status: 400 });
  }

  const sql = getSql();

  const editions = await sql<{ id: string; festival_id: string }[]>`
    select id, festival_id
    from public.festival_editions
    where id::text = ${id} or festival_id::text = ${id}
    order by year desc nulls last, start_date desc nulls last
    limit 1
  `;

  if (!editions[0]) {
    return NextResponse.json({ error: "Edición no encontrada" }, { status: 404 });
  }

  const [updated] = await sql<{ id: string; commercial_stage: string }[]>`
    update public.festival_editions
    set commercial_stage = ${stage}, last_checked_at = now()
    where id = ${editions[0].id}
    returning id, commercial_stage
  `;

  return NextResponse.json({ ok: true, edition: updated });
}
