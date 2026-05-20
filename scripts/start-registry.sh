#!/usr/bin/env sh
set -eu

cd "$(dirname "$0")/.."

docker compose -p tp13-registry --env-file .env -f docker-compose.registry.yml up -d --force-recreate
sleep 2
curl -sf "http://127.0.0.1:${REGISTRY_PORT:-5000}/v2/" >/dev/null && echo "Registry OK on port ${REGISTRY_PORT:-5000}"
curl -sf "http://127.0.0.1:${REGISTRY_UI_PORT:-8081}/" >/dev/null && echo "Registry UI OK on port ${REGISTRY_UI_PORT:-8081}" || echo "Registry UI: use SSH tunnel if port blocked externally"
