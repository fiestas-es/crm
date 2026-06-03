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
          <p className="muted">Historial de textos generados por canal. Se guardan como borrador, no se envían solos.</p>
        </div>
      </div>

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
