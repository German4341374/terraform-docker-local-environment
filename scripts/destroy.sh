#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
require_password
read -r -p "Destroy ${environment}, including managed volumes? Type DESTROY: " confirmation
[[ "${confirmation}" == "DESTROY" ]] || { echo "Destroy cancelled."; exit 1; }
terraform destroy -input=false -var-file="${tfvars}"
