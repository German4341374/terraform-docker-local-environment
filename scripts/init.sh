#!/usr/bin/env bash
set -Eeuo pipefail
terraform init -upgrade=false
terraform validate
