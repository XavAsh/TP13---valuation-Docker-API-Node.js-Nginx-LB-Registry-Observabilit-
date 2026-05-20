#!/usr/bin/env sh
set -eu

if [ -z "${GIT_SHA:-}" ]; then
  echo "GIT_SHA is required (example: export GIT_SHA=abc1234)"
  exit 1
fi

docker compose --env-file .env -f docker-compose.prod.yml up -d
docker compose -f docker-compose.prod.yml ps
