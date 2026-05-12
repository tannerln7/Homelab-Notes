#!/bin/bash
set -e
PORT="${ROCKET_PORT:-8080}"
curl -fsS "<REDACTED_URL>" >/dev/null 2>&1 || \
curl -fsS "<REDACTED_URL>" >/dev/null