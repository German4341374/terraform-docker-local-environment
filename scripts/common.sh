#!/usr/bin/env bash
set -Eeuo pipefail

environment="${1:-development}"
case "${environment}" in
  development|staging) ;;
  *) echo "Environment must be development or staging." >&2; exit 1 ;;
esac

tfvars="environments/${environment}.tfvars"
[[ -f "${tfvars}" ]] || { echo "Missing ${tfvars}." >&2; exit 1; }

require_password() {
  if [[ -z "${TF_VAR_postgres_password:-}" ]]; then
    echo "Set TF_VAR_postgres_password to a generated local value of at least 16 characters." >&2
    exit 1
  fi
}
