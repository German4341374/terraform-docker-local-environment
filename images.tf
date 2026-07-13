resource "docker_image" "proxy" {
  name         = var.images.proxy
  keep_locally = true
}

resource "docker_image" "app" {
  name         = var.images.app
  keep_locally = true
}

resource "docker_image" "database" {
  name         = var.images.database
  keep_locally = true
}
