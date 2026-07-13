locals {
  prefix = "${var.project_name}-${var.environment}"

  app_instances = {
    for index in range(var.app_replicas) : format("app-%02d", index + 1) => {
      name = format("%s-app-%02d", local.prefix, index + 1)
    }
  }

  volume_names = {
    postgres = "${local.prefix}-postgres-data"
    proxy    = "${local.prefix}-proxy-cache"
  }

  common_labels = {
    "managed-by"  = "terraform"
    "project"     = var.project_name
    "environment" = var.environment
  }
}
