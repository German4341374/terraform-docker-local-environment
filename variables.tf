variable "environment" {
  description = "Logical environment name used in Docker resource names."
  type        = string
  default     = "development"

  validation {
    condition     = contains(["development", "staging"], var.environment)
    error_message = "Environment must be development or staging."
  }
}

variable "project_name" {
  description = "Lowercase project identifier used as a resource prefix."
  type        = string
  default     = "tf-docker-app"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,30}$", var.project_name))
    error_message = "Project name must be 3-31 lowercase letters, digits, or hyphens."
  }
}

variable "docker_host" {
  description = "Docker daemon socket visible from Terraform."
  type        = string
  default     = "unix:///var/run/docker.sock"

  validation {
    condition     = startswith(var.docker_host, "unix://") || startswith(var.docker_host, "npipe://")
    error_message = "Docker host must use a local unix:// or npipe:// socket."
  }
}

variable "proxy_port" {
  description = "Host port published by the reverse proxy."
  type        = number
  default     = 8080

  validation {
    condition     = var.proxy_port >= 1024 && var.proxy_port <= 65535
    error_message = "Proxy port must be between 1024 and 65535."
  }
}

variable "app_replicas" {
  description = "Number of application containers behind Nginx."
  type        = number
  default     = 2

  validation {
    condition     = var.app_replicas >= 2 && var.app_replicas <= 5 && floor(var.app_replicas) == var.app_replicas
    error_message = "Application replicas must be an integer between 2 and 5."
  }
}

variable "network_internal" {
  description = "Prevent containers on the application network from external network access."
  type        = bool
  default     = true
}

variable "postgres_user" {
  description = "PostgreSQL application user."
  type        = string
  default     = "taskapp"

  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{2,30}$", var.postgres_user))
    error_message = "PostgreSQL user must be a safe lowercase identifier."
  }
}

variable "postgres_database" {
  description = "PostgreSQL database name."
  type        = string
  default     = "tasks"

  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{2,30}$", var.postgres_database))
    error_message = "Database name must be a safe lowercase identifier."
  }
}

variable "postgres_password" {
  description = "PostgreSQL password supplied with TF_VAR_postgres_password."
  type        = string
  sensitive   = true
  nullable    = false

  validation {
    condition     = length(var.postgres_password) >= 16
    error_message = "PostgreSQL password must contain at least 16 characters."
  }
}

variable "images" {
  description = "Pinned container images."
  type = object({
    proxy    = string
    app      = string
    database = string
  })
  default = {
    proxy    = "nginxinc/nginx-unprivileged:1.30.3-alpine3.23"
    app      = "traefik/whoami:v1.11.0"
    database = "postgres:17.4-alpine3.21"
  }

  validation {
    condition     = alltrue([for image in values(var.images) : !endswith(image, ":latest")])
    error_message = "Container images must use explicit non-latest tags."
  }
}
