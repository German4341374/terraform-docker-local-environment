#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
require_password
plan="plans/${environment}.tfplan"
[[ -f "${plan}" ]] || { echo "Run scripts/plan.sh ${environment} first." >&2; exit 1; }
read -r -p "Apply reviewed plan ${plan}? Type APPLY: " confirmation
[[ "${confirmation}" == "APPLY" ]] || { echo "Apply cancelled."; exit 1; }
terraform apply "${plan}"
