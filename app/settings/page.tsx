export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";

export default function SettingsPage() {
  return (
    <Shell>
      <div className="topbar">
        <div>
          <p className="eyebrow">Ajustes</p>
          <h1>Configuración del sistema</h1>
          <p className="muted">Variables, fuentes, cron y seguridad para dejar el radar funcionando online.</p>
        </div>
      </div>

      <section className="grid two">
        <div className="card">
          <h2>Variables necesarias</h2>
          <div className="kv">
            <div><span>TEAM_ACCESS_PASSWORD</span><strong>Contraseña interna</strong></div>
            <div><span>CRON_SECRET</span><strong>Token del radar semanal</strong></div>
            <div><span>SUPABASE_SERVICE_ROLE_KEY</span><strong>Servidor</strong></div>
            <div><span>OPENAI_API_KEY</span><strong>Propuestas IA</strong></div>
          </div>
        </div>
        <div className="card">
          <h2>Fuentes preparadas</h2>
          <p className="muted">El radar incluye conector Ticketmaster y estructura para añadir Songkick, ticketeras, webs oficiales e imports manuales.</p>
          <span className="badge blue">Ticketmaster API</span>{" "}
          <span className="badge purple">CSV</span>{" "}
          <span className="badge green">Manual</span>
        </div>
      </section>
    </Shell>
  );
}
