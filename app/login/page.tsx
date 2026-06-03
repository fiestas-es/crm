type LoginPageProps = {
  searchParams?: Promise<{ error?: string; next?: string }>;
};

export default async function LoginPage({ searchParams }: LoginPageProps) {
  const params = searchParams ? await searchParams : {};

  return (
    <main className="login-shell">
      <section className="card login-card">
        <div className="login-logo">FR</div>
        <p className="eyebrow">Acceso privado</p>
        <h1>Fiestas Radar</h1>
        <p className="muted">Panel interno de festivales, contactos, radar semanal y propuestas para el equipo.</p>

        {params?.error ? <p className="error">Contraseña incorrecta.</p> : null}

        <form action="/api/login" method="post" className="grid">
          <input type="hidden" name="next" value={params?.next || "/dashboard"} />
          <input className="input" type="password" name="password" placeholder="Contraseña del equipo" required autoFocus />
          <button className="btn primary" type="submit">Entrar al radar</button>
        </form>
      </section>
    </main>
  );
}
