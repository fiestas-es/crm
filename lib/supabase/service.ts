import { createClient } from "@supabase/supabase-js";

function cleanUrl(value?: string) {
  if (!value) return "";
  return value
    .trim()
    .replace(/^['"]|['"]$/g, "")
    .replace(/\/rest\/v1\/?$/, "")
    .replace(/\/$/, "");
}

function readSupabaseUrl() {
  return cleanUrl(
    process.env.NEXT_PUBLIC_SUPABASE_URL ||
      process.env.SUPABASE_URL ||
      process.env.POSTGRES_URL
  );
}

function readSupabaseKey() {
  return (
    process.env.SUPABASE_SERVICE_ROLE_KEY ||
    process.env.SUPABASE_SERVICE_KEY ||
    process.env.SUPABASE_SECRET_KEY ||
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
    process.env.SUPABASE_ANON_KEY ||
    ""
  ).trim();
}

export function getSupabaseDebugInfo() {
  const rawUrl =
    process.env.NEXT_PUBLIC_SUPABASE_URL ||
    process.env.SUPABASE_URL ||
    process.env.POSTGRES_URL ||
    "";

  const url = readSupabaseUrl();
  const key = readSupabaseKey();

  let parsedHost: string | null = null;

  try {
    parsedHost = url ? new URL(url).host : null;
  } catch {
    parsedHost = "INVALID_URL";
  }

  return {
    hasRawUrl: Boolean(rawUrl),
    rawUrlPreview: rawUrl
      ? rawUrl.slice(0, 28) + "..." + rawUrl.slice(-12)
      : null,
    normalizedUrl: url
      ? url.slice(0, 28) + "..." + url.slice(-12)
      : null,
    parsedHost,
    urlIncludesRestV1: rawUrl.includes("/rest/v1"),
    hasKey: Boolean(key),
    keyPrefix: key ? key.slice(0, 14) : null,
    keyLength: key.length,
    using: {
      NEXT_PUBLIC_SUPABASE_URL: Boolean(process.env.NEXT_PUBLIC_SUPABASE_URL),
      SUPABASE_URL: Boolean(process.env.SUPABASE_URL),
      POSTGRES_URL: Boolean(process.env.POSTGRES_URL),
      SUPABASE_SERVICE_ROLE_KEY: Boolean(process.env.SUPABASE_SERVICE_ROLE_KEY),
      SUPABASE_SERVICE_KEY: Boolean(process.env.SUPABASE_SERVICE_KEY),
      SUPABASE_SECRET_KEY: Boolean(process.env.SUPABASE_SECRET_KEY),
      NEXT_PUBLIC_SUPABASE_ANON_KEY: Boolean(process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY),
      SUPABASE_ANON_KEY: Boolean(process.env.SUPABASE_ANON_KEY)
    }
  };
}

export function hasSupabaseEnv() {
  return Boolean(readSupabaseUrl() && readSupabaseKey());
}

export function createServiceClient() {
  const url = readSupabaseUrl();
  const key = readSupabaseKey();

  if (!url || !key) {
    throw new Error("Faltan URL o KEY de Supabase en Vercel");
  }

  return createClient(url, key, {
    auth: {
      persistSession: false,
      autoRefreshToken: false
    }
  });
}
