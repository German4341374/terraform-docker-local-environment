output "application_url" {
  description = "Loopback URL published by the Nginx proxy."
  value       = "http://127.0.0.1:${var.proxy_port}"
}

output "application_containers" {
  description = "Application container names managed with for_each."
  value       = [for container in docker_container.app : container.name]
}

output "network_name" {
  description = "Custom Docker network name."
  value       = docker_network.application.name
}

output "persistent_volumes" {
  description = "Persistent Docker volume names."
  value       = { for key, volume in docker_volume.persistent : key => volume.name }
}

output "database_connection" {
  description = "Internal PostgreSQL connection string for demonstration; stored in Terraform state."
  value       = "postgresql://${var.postgres_user}:${var.postgres_password}@database:5432/${var.postgres_database}"
  sensitive   = true
}
