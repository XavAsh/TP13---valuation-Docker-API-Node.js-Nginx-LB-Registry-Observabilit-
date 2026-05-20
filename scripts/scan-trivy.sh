#!/usr/bin/env sh
set -eu

IMAGE="${1:-localhost:5000/mon-api:1.0.0}"

trivy image --severity CRITICAL --ignore-unfixed "${IMAGE}"
