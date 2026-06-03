import { NextResponse } from "next/server";
import {
  createServiceClient,
  getSupabaseDebugInfo,
  hasSupabaseEnv
} from "@/lib/supabase/service";

export const dynamic = "force-dynamic";
export const revalidate = 0;

async function testDirectFetch() {
  const info = getSupabaseDebugInfo();

  if (!info.parsedHost || info.parsedHost === "INVALID_URL") {
    return {
      ok: false,
      reason: "URL inválida o ausente"
    };
  }

  try {
    const url =
      `https://${info.parsedHost}/rest/v1/festivals?select=id&limit=1`;

    const response = await fetch(url, {
      headers: {
        apikey:
          process.env.SUPABASE_SERVICE_ROLE_KEY ||
          process.env.SUPABASE_SERVICE_KEY ||
          process.env.SUPABASE_SECRET_KEY ||
          process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
          process.env.SUPABASE_ANON_KEY ||
          "",
        Authorization:
          "Bearer " +
          (
            process.env.SUPABASE_SERVICE_ROLE_KEY ||
            process.env.SUPABASE_SERVICE_KEY ||
            process.env.SUPABASE_SECRET_KEY ||
            process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
            process.env.SUPABASE_ANON_KEY ||
            ""
          )
      },
      cache: "no-store"
    });

    return {
      ok: response.ok,
      status: response.status,
      statusText: response.statusText,
      contentRange: response.headers.get("content-range"),
      bodyPreview: (await response.text()).slice(0, 300)
    };
  } catch (error: any) {
    return {
      ok: false,
      errorName: error?.name || null,
      errorMessage: error?.message || String(error)
    };
  }
}

export async function GET() {
  const env = getSupabaseDebugInfo();

  if (!hasSupabaseEnv()) {
    return NextResponse.json({
      ok: false,
      reason: "Sin variables Supabase válidas en Vercel",
      env
    });
  }

  const directFetch = await testDirectFetch();

  let counts = {
    festivals: 0,
    editions: 0,
    contacts: 0
  };

  let errors: Record<string, any> = {};

  try {
    const supabase = createServiceClient();

    const [festivals, editions, contacts] = await Promise.all([
      supabase.from("festivals").select("id", { count: "exact", head: true }),
      supabase.from("festival_editions").select("id", { count: "exact", head: true }),
      supabase.from("contacts").select("id", { count: "exact", head: true })
    ]);

    counts = {
      festivals: festivals.count ?? 0,
      editions: editions.count ?? 0,
      contacts: contacts.count ?? 0
    };

    errors = {
      festivals: festivals.error?.message ?? null,
      editions: editions.error?.message ?? null,
      contacts: contacts.error?.message ?? null
    };
  } catch (error: any) {
    errors = {
      global: error?.message || String(error)
    };
  }

  return NextResponse.json({
    ok: true,
    env,
    directFetch,
    counts,
    errors
  });
}
