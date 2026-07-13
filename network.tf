resource "docker_network" "application" {
  name     = "${local.prefix}-network"
  driver   = "bridge"
  internal = var.network_internal

  labels {
    label = "managed-by"
    value = "terraform"
  }
}
