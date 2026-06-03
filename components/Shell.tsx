import Link from "next/link";

const nav = [
  { href: "/dashboard", label: "Dashboard", icon: "⚡" },
  { href: "/festivals", label: "Festivales", icon: "🎪" },
  { href: "/radar", label: "Radar semanal", icon: "📡" },
  { href: "/contacts", label: "Contactos", icon: "👥" },
  { href: "/proposals", label: "Propuestas", icon: "✍️" },
  { href: "/settings", label: "Ajustes", icon: "⚙️" }
];

export function Shell({ children }: { children: React.ReactNode }) {
  return (
    <div className="app-shell">
      <aside className="sidebar">
        <Link href="/dashboard" className="brand">
          <div className="brand-mark">FR</div>
          <div>
            <strong>Fiestas Radar</strong>
            <small>Festival CRM interno</small>
          </div>
        </Link>

        <nav className="nav">
          {nav.map((item) => (
            <Link key={item.href} href={item.href}>
              <span>{item.icon}</span> {item.label}
            </Link>
          ))}
          <form action="/api/logout" method="post">
            <button type="submit"><span>🔒</span> Salir</button>
          </form>
        </nav>

        <div className="sidebar-footer">
          <strong>@fiestas_es</strong><br />
          Radar de oportunidades, contactos y propuestas. Actualización semanal preparada para cron.
        </div>
      </aside>
      <main className="main">{children}</main>
    </div>
  );
}
