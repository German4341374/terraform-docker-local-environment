resource "docker_volume" "persistent" {
  for_each = local.volume_names

  name = each.value

  labels {
    label = "managed-by"
    value = "terraform"
  }

  labels {
    label = "environment"
    value = var.environment
  }
}
