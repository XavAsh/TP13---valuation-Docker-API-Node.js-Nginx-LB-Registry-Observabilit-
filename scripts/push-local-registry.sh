#!/usr/bin/env sh
set -eu

IMAGE_NAME="${1:-mon-api:1.0.0}"
TARGET_IMAGE="${2:-localhost:5000/mon-api:1.0.0}"

docker compose --env-file .env -f docker-compose.registry.yml up -d
docker tag "${IMAGE_NAME}" "${TARGET_IMAGE}"
docker push "${TARGET_IMAGE}"

echo "Image pushed to ${TARGET_IMAGE}"
