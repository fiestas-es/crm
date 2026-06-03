import { NextResponse } from "next/server";
import { createServiceClient, hasSupabaseEnv } from "@/lib/supabase/service";

export const dynamic = "force-dynamic";

export async function GET() {
  if (!hasSupabaseEnv()) {
    return NextResponse.json({ ok: false, reason: "Sin variables Supabase en Vercel" });
  }

  const supabase = createServiceClient();
  const [festivals, editions, contacts] = await Promise.all([
    supabase.from("festivals").select("id", { count: "exact", head: true }),
    supabase.from("festival_editions").select("id", { count: "exact", head: true }),
    supabase.from("contacts").select("id", { count: "exact", head: true })
  ]);

  return NextResponse.json({
    ok: true,
    counts: {
      festivals: festivals.count ?? 0,
      editions: editions.count ?? 0,
      contacts: contacts.count ?? 0
    },
    errors: {
      festivals: festivals.error?.message ?? null,
      editions: editions.error?.message ?? null,
      contacts: contacts.error?.message ?? null
    }
  });
}
