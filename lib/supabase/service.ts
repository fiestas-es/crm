import { createClient } from "@supabase/supabase-js";

function stripQuotes(value: string) {
  const trimmed = value.trim();
  if ((trimmed.startsWith('"') && trimmed.endsWith('"')) || (trimmed.startsWith("'") && trimmed.endsWith("'"))) {
    return trimmed.slice(1, -1).trim();
  }
  return trimmed;
}

export function normalizeSupabaseUrl(input?: string) {
  if (!input) return "";
  let url = stripQuotes(input);
  url = url.replace(/\s+/g, "");
  url = url.replace(/\/rest\/v1\/?$/i, "");
  url = url.replace(/\/+$/g, "");
  return url;
}

export function normalizeSupabaseKey(input?: string) {
  if (!input) return "";
  return stripQuotes(input).replace(/\s+/g, "");
}

export function getSupabaseConfig() {
  const rawUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || "";
  const rawServiceRole = process.env.SUPABASE_SERVICE_ROLE_KEY || "";
  const rawAnon = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";

  return {
    rawUrl,
    url: normalizeSupabaseUrl(rawUrl),
    serviceRole: normalizeSupabaseKey(rawServiceRole),
    anonKey: normalizeSupabaseKey(rawAnon)
  };
}

export function hasSupabaseEnv() {
  const cfg = getSupabaseConfig();
  return Boolean(cfg.url && cfg.serviceRole);
}

export function createServiceClient() {
  const cfg = getSupabaseConfig();

  if (!cfg.url || !cfg.serviceRole) {
    throw new Error("Faltan NEXT_PUBLIC_SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY");
  }

  return createClient(cfg.url, cfg.serviceRole, {
    auth: {
      persistSession: false,
      autoRefreshToken: false
    }
  });
}

export function maskedConfigForDebug() {
  const cfg = getSupabaseConfig();
  let parsed: URL | null = null;
  try {
    parsed = cfg.url ? new URL(cfg.url) : null;
  } catch {
    parsed = null;
  }

  return {
    hasRawUrl: Boolean(cfg.rawUrl),
    rawUrlLength: cfg.rawUrl.length,
    normalizedUrl: cfg.url ? `${cfg.url.slice(0, 12)}…${cfg.url.slice(-12)}` : null,
    normalizedUrlLength: cfg.url.length,
    parsedHost: parsed?.host || null,
    parsedProtocol: parsed?.protocol || null,
    urlIncludesRestV1: /\/rest\/v1\/?$/i.test(cfg.rawUrl),
    hasServiceRole: Boolean(cfg.serviceRole),
    serviceRolePrefix: cfg.serviceRole ? cfg.serviceRole.slice(0, 12) : null,
    serviceRoleLength: cfg.serviceRole.length,
    hasAnonKey: Boolean(cfg.anonKey),
    anonKeyPrefix: cfg.anonKey ? cfg.anonKey.slice(0, 14) : null,
    anonKeyLength: cfg.anonKey.length
  };
}
