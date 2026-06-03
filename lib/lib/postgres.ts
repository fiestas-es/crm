import postgres from "postgres";

let client: ReturnType<typeof postgres> | null = null;

function clean(value?: string) {
  return (value || "").trim().replace(/^['"]|['"]$/g, "");
}

export function getPostgresUrl() {
  return clean(
    process.env.POSTGRES_URL ||
      process.env.POSTGRES_PRISMA_URL ||
      process.env.DATABASE_URL ||
      process.env.POSTGRES_URL_NON_POOLING
  );
}

export function hasPostgresEnv() {
  return Boolean(getPostgresUrl());
}

export function getPostgresDebugInfo() {
  const url = getPostgresUrl();

  return {
    hasPostgresUrl: Boolean(url),
    postgresUrlPreview: url
      ? url.slice(0, 18) + "..." + url.slice(-18)
      : null
  };
}

export function getSql() {
  const url = getPostgresUrl();

  if (!url) {
    throw new Error("Falta POSTGRES_URL en Vercel");
  }

  if (!client) {
    client = postgres(url, {
      ssl: "require",
      max: 1,
      idle_timeout: 5,
      connect_timeout: 10,
      prepare: false
    });
  }

  return client;
}
