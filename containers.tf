resource "docker_container" "database" {
  name     = "${local.prefix}-postgres"
  hostname = "database"
  image    = docker_image.database.image_id
  user     = "70:70"
  restart  = "unless-stopped"

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_database}",
  ]

  networks_advanced {
    name    = docker_network.application.name
    aliases = ["database"]
  }

  volumes {
    volume_name    = docker_volume.persistent["postgres"].name
    container_path = "/var/lib/postgresql/data"
  }

  healthcheck {
    test         = ["CMD-SHELL", "pg_isready -U ${var.postgres_user} -d ${var.postgres_database}"]
    interval     = "10s"
    timeout      = "5s"
    retries      = 5
    start_period = "15s"
  }

  security_opts = ["no-new-privileges:true"]

  dynamic "labels" {
    for_each = local.common_labels
    content {
      label = labels.key
      value = labels.value
    }
  }
}

resource "docker_container" "app" {
  for_each = local.app_instances

  name      = each.value.name
  hostname  = each.key
  image     = docker_image.app.image_id
  restart   = "unless-stopped"
  read_only = true
  command   = ["--port=8080", "--name=${each.value.name}"]

  networks_advanced {
    name    = docker_network.application.name
    aliases = [each.value.name]
  }

  healthcheck {
    test         = ["CMD", "/whoami", "--healthcheck"]
    interval     = "10s"
    timeout      = "3s"
    retries      = 3
    start_period = "5s"
  }

  security_opts = ["no-new-privileges:true"]

  capabilities {
    drop = ["ALL"]
  }

  dynamic "labels" {
    for_each = local.common_labels
    content {
      label = labels.key
      value = labels.value
    }
  }
}

resource "docker_container" "proxy" {
  name      = "${local.prefix}-proxy"
  hostname  = "proxy"
  image     = docker_image.proxy.image_id
  user      = "101:101"
  restart   = "unless-stopped"
  read_only = true

  networks_advanced {
    name = docker_network.application.name
  }

  ports {
    internal = 8080
    external = var.proxy_port
    protocol = "tcp"
    ip       = "127.0.0.1"
  }

  upload {
    content = templatefile("${path.module}/templates/nginx.conf.tftpl", {
      app_names = [for app in values(local.app_instances) : app.name]
    })
    file = "/etc/nginx/conf.d/default.conf"
  }

  volumes {
    volume_name    = docker_volume.persistent["proxy"].name
    container_path = "/var/cache/nginx"
  }

  tmpfs = {
    "/tmp"     = "rw,noexec,nosuid,size=16m"
    "/var/run" = "rw,noexec,nosuid,size=4m"
  }

  healthcheck {
    test         = ["CMD-SHELL", "wget -q -O - http://127.0.0.1:8080/health || exit 1"]
    interval     = "10s"
    timeout      = "3s"
    retries      = 3
    start_period = "5s"
  }

  security_opts = ["no-new-privileges:true"]

  capabilities {
    drop = ["ALL"]
  }

  depends_on = [docker_container.app]

  dynamic "labels" {
    for_each = local.common_labels
    content {
      label = labels.key
      value = labels.value
    }
  }
}
