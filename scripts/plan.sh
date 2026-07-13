#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
require_password
mkdir -p plans
terraform plan -input=false -var-file="${tfvars}" -out="plans/${environment}.tfplan"
terraform show -no-color "plans/${environment}.tfplan" > "plans/${environment}.txt"
echo "Plan saved under plans/. Review it before applying."
