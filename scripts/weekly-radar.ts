const endpoint = process.env.RADAR_ENDPOINT || "http://localhost:3000/api/radar/run";
const secret = process.env.CRON_SECRET;

async function main() {
  const response = await fetch(endpoint, {
    method: "GET",
    headers: secret ? { authorization: `Bearer ${secret}` } : {}
  });
  const json = await response.json();
  if (!response.ok) throw new Error(JSON.stringify(json));
  console.log(json);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
