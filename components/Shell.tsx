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
    <div className="app-shell app-shell-v7">
      <aside className="sidebar sidebar-v7">
        <Link href="/dashboard" className="brand brand-v7">
          <span className="brand-mark brand-mark-v7">
            <img src="/brand/icon.svg" alt="Fiestas" />
          </span>
          <span>
            <strong>Fiestas Radar</strong>
            <small>Festival CRM interno</small>
          </span>
        </Link>

        <nav className="nav nav-v7">
          {nav.map((item) => (
            <Link href={item.href} key={item.href}>
              <span>{item.icon}</span>
              {item.label}
            </Link>
          ))}
          <form action="/logout" method="post">
            <button type="submit"><span>🔒</span> Salir</button>
          </form>
        </nav>

        <div className="sidebar-footer">
          <strong>@fiestas_es</strong>
          <br />
          Radar comercial, contactos, propuestas y seguimiento semanal.
        </div>
      </aside>
      <main className="main main-v7">{children}</main>
    </div>
  );
}
