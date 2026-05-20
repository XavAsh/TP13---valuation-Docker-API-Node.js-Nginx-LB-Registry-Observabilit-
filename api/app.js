const express = require("express");
const os = require("os");
const client = require("prom-client");

const app = express();
const registry = new client.Registry();

client.collectDefaultMetrics({ register: registry });

const requestsCounter = new client.Counter({
  name: "api_requests_total",
  help: "Total number of API requests handled",
  labelNames: ["route", "method"]
});

registry.registerMetric(requestsCounter);

let requestCount = 0;
const port = Number(process.env.API_PORT || 3000);
const pet = process.env.PET || "unknown";

app.get("/", (req, res) => {
  requestCount += 1;
  requestsCounter.inc({ route: "/", method: "GET" });
  res.status(200).json({
    hostname: os.hostname(),
    pet,
    requests: requestCount
  });
});

app.get("/healthz", (req, res) => {
  res.status(200).json({ status: "ok" });
});

app.get("/metrics", async (req, res) => {
  res.set("Content-Type", registry.contentType);
  res.end(await registry.metrics());
});

app.listen(port, () => {
  console.log(`API listening on port ${port}`);
});
