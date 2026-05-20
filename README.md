# TP13 - Docker Stack

## Partie 1 - API & Dockerfile

API Node.js (Express) avec:
- `GET /` retourne `hostname`, `pet`, `requests`.
- `GET /healthz` retourne `{ "status": "ok" }`.
- `GET /metrics` expose les métriques Prometheus (`prom-client`).

Build API:

```bash
docker build -t mon-api:1.0.0 -f api/Dockerfile api
```

## Partie 2 - Registry privé local

Lancer le registry et l'UI:

```bash
docker compose --env-file .env -f docker-compose.registry.yml up -d
```

Tag + push de l'image API:

```bash
docker tag mon-api:1.0.0 localhost:5000/mon-api:1.0.0
docker push localhost:5000/mon-api:1.0.0
```

## Partie 3 - Stack principale

Lancer la stack:

```bash
docker compose --env-file .env -f docker-compose.yml up -d
```

Tests rapides:
- `curl http://localhost:${NGINX_PORT}/` (round-robin cat/dog)
- `curl http://localhost:${NGINX_PORT}/cat` (toujours cat)
- `curl http://localhost:${NGINX_PORT}/dog` (toujours dog)

## Partie 4 - Variables d'environnement et sécurité

Toutes les variables sont dans `.env`.

Scan Trivy:

```bash
trivy image --severity CRITICAL --ignore-unfixed localhost:5000/mon-api:1.0.0
```

Justification image de base:
- `node:20-alpine` est plus légère que `node:latest`.
- Surface d'attaque plus petite.
- En pratique, le nombre de CVE est généralement inférieur à une image `latest` plus large (à confirmer via scan local Trivy dans votre environnement).

## Partie 7 - Observabilité

Services inclus:
- Prometheus
- Grafana
- node-exporter
- cadvisor

Endpoints utiles:
- Prometheus: `http://localhost:${PROMETHEUS_PORT}`
- Grafana: `http://localhost:${GRAFANA_PORT}`

## Partie 8 - Volumes

- Volumes nommés: `registry_data`, `grafana_data`.
- Bind mounts: configs Nginx, Prometheus et provisioning Grafana.

## Partie 9 - CI/CD GitHub Actions

Workflow: `.github/workflows/docker.yml`
- Trigger: push sur `main`
- Build image API
- Trivy CRITICAL (fail pipeline si vulnérabilités)
- Push vers GHCR avec tag `git-<short_sha>`

## Partie 10 - VPS

Déploiement production:

```bash
export GIT_SHA=<short_sha>
docker compose --env-file .env -f docker-compose.prod.yml up -d
```

À compléter après déploiement:
- URL/IP publique: `<A_COMPLETER>`
- Capture d'écran de la stack depuis le VPS: `captures/<A_COMPLETER>.png`
