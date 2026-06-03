import { Shell } from "@/components/Shell";
import { getProposals } from "@/lib/data";
import { channelLabel, formatDate } from "@/lib/utils";

export default async function ProposalsPage() {
  const proposals = await getProposals();

  return (
    <Shell>
      <div className="topbar">
        <div>
          <p className="eyebrow">Propuestas</p>
          <h1>Borradores generados</h1>
          <p className="muted">Aquí se guardan los textos. Para generar uno nuevo entra en la ficha de un festival y elige Email, WhatsApp, DM de Instagram o llamada.</p>
        </div>
        <a className="btn primary" href="/festivals">Elegir festival</a>
      </div>

      <section className="card" style={{ marginBottom: 18 }}>
        <p className="eyebrow">Cómo generar</p>
        <h2>Flujo práctico</h2>
        <div className="grid three">
          <div className="pipeline-item"><strong>1. Abre un festival</strong><p className="muted">Ejemplo: Mad Cool, Arenal Sound, Cruïlla...</p></div>
          <div className="pipeline-item"><strong>2. Elige responsable</strong><p className="muted">Marketing, patrocinios, prensa o agencia.</p></div>
          <div className="pipeline-item"><strong>3. Elige canal</strong><p className="muted">Email, WhatsApp, Instagram DM o llamada.</p></div>
        </div>
      </section>

      <div className="grid">
        {proposals.map((proposal) => (
          <article className="card" key={proposal.id}>
            <div className="card-top">
              <div>
                <span className="badge purple">{channelLabel(proposal.channel)}</span>
                <h2 style={{ marginTop: 12 }}>{proposal.festival_name || "Festival"}</h2>
                <p className="muted">{proposal.objective || "Propuesta comercial"} · {proposal.created_at ? formatDate(proposal.created_at) : ""}</p>
              </div>
              <span className="badge green">{proposal.status}</span>
            </div>
            {proposal.subject ? <p><strong>Asunto:</strong> {proposal.subject}</p> : null}
            <textarea className="textarea" readOnly value={proposal.body} />
          </article>
        ))}
      </div>
    </Shell>
  );
}
