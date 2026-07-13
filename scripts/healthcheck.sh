#!/usr/bin/env bash
set -Eeuo pipefail
url="${1:-http://127.0.0.1:8080/health}"
curl --fail --silent --show-error "${url}"
echo
