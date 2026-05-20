#!/usr/bin/env sh
set -eu

cd "$(dirname "$0")/.."
NGINX_PORT="$(grep -E '^NGINX_PORT=' .env | cut -d= -f2 | tr -d ' \r')"

echo "=== docker compose ps (prod) ==="
docker compose -f docker-compose.prod.yml ps

echo ""
echo "=== Partie 5: load balancing / ==="
for i in 1 2 3 4; do
  curl -s "http://127.0.0.1:${NGINX_PORT}/"
  echo ""
done

echo ""
echo "=== /cat (PET=cat) ==="
curl -s "http://127.0.0.1:${NGINX_PORT}/cat"
echo ""

echo ""
echo "=== /dog (PET=dog) ==="
curl -s "http://127.0.0.1:${NGINX_PORT}/dog"
echo ""
