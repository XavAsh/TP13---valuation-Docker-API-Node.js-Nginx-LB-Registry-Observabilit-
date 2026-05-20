#!/usr/bin/env sh
set -eu

if [ -z "${GIT_SHA:-}" ]; then
  echo "GIT_SHA is required (example: export GIT_SHA=abc1234)"
  exit 1
fi

IMAGE_OWNER="$(grep -E '^API_IMAGE_PUBLIC=' .env | cut -d= -f2 | tr -d ' \r')"
export API_IMAGE_LOCAL="${IMAGE_OWNER}:git-${GIT_SHA}"

docker compose -f docker-compose.yml down --remove-orphans 2>/dev/null || true
docker compose -f docker-compose.yml -f docker-compose.prod.yml down --remove-orphans 2>/dev/null || true
docker rm -f tp13_grafana tp13_prometheus tp13_nginx tp13_cat tp13_dog tp13_portainer 2>/dev/null || true
for cid in $(docker ps -q --filter "publish=3001"); do docker rm -f "${cid}"; done

docker compose --env-file .env -f docker-compose.yml -f docker-compose.prod.yml pull cat dog
docker compose --env-file .env -f docker-compose.yml -f docker-compose.prod.yml up -d --remove-orphans
docker compose -f docker-compose.yml -f docker-compose.prod.yml ps
