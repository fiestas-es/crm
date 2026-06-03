import { NextResponse } from "next/server";
import { createServiceClient, getSupabaseConfig, hasSupabaseEnv, maskedConfigForDebug } from "@/lib/supabase/service";

export const dynamic = "force-dynamic";
export const revalidate = 0;

type TestResult = {
  ok: boolean;
  status?: number;
  statusText?: string;
  contentRange?: string | null;
  bodyPreview?: string;
  error?: string;
};

async function testDirectFetch(table: string): Promise<TestResult> {
  const cfg = getSupabaseConfig();
  const url = `${cfg.url}/rest/v1/${table}?select=id`;
  try {
    const response = await fetch(url, {
      method: "GET",
      headers: {
        apikey: cfg.serviceRole,
        Authorization: `Bearer ${cfg.serviceRole}`,
        Prefer: "count=exact",
        Range: "0-0"
      },
      cache: "no-store",
      signal: AbortSignal.timeout(12000)
    });
    const text = await response.text();
    return {
      ok: response.ok,
      status: response.status,
      statusText: response.statusText,
      contentRange: response.headers.get("content-range"),
      bodyPreview: text.slice(0, 300)
    };
  } catch (error: any) {
    return {
      ok: false,
      error: `${error?.name || "Error"}: ${error?.message || String(error)}`
    };
  }
}

export async function GET() {
  if (!hasSupabaseEnv()) {
    return NextResponse.json({ ok: false, reason: "Sin variables Supabase en Vercel", env: maskedConfigForDebug() });
  }

  const supabase = createServiceClient();
  const [festivals, editions, contacts, directFestivals] = await Promise.all([
    supabase.from("festivals").select("id", { count: "exact", head: true }),
    supabase.from("festival_editions").select("id", { count: "exact", head: true }),
    supabase.from("contacts").select("id", { count: "exact", head: true }),
    testDirectFetch("festivals")
  ]);

  return NextResponse.json({
    ok: true,
    env: maskedConfigForDebug(),
    counts: {
      festivals: festivals.count ?? 0,
      editions: editions.count ?? 0,
      contacts: contacts.count ?? 0
    },
    errors: {
      festivals: festivals.error?.message ?? null,
      editions: editions.error?.message ?? null,
      contacts: contacts.error?.message ?? null
    },
    directFetch: {
      festivals: directFestivals
    }
  });
}
