export function StatCard({ label, value, delta }: { label: string; value: string | number; delta?: string }) {
  return (
    <div className="card stat-card">
      {delta ? <div className="stat-delta">{delta}</div> : null}
      <div className="stat-value">{value}</div>
      <div className="stat-label">{label}</div>
    </div>
  );
}
