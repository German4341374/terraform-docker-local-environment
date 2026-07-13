mock_provider "docker" {}

run "development_plan" {
  command = plan

  variables {
    environment       = "development"
    postgres_password = "test-only-password-not-a-secret"
  }

  assert {
    condition     = length(output.application_containers) == 2
    error_message = "Development must create two application replicas by default."
  }

  assert {
    condition     = output.application_url == "http://127.0.0.1:8080"
    error_message = "Development URL must use the default loopback port."
  }
}

run "staging_replica_override" {
  command = plan

  variables {
    environment       = "staging"
    app_replicas      = 3
    proxy_port        = 8081
    postgres_password = "test-only-password-not-a-secret"
  }

  assert {
    condition     = length(output.application_containers) == 3
    error_message = "Staging must honor the replica override."
  }
}

run "reject_privileged_port" {
  command = plan

  variables {
    proxy_port        = 80
    postgres_password = "test-only-password-not-a-secret"
  }

  expect_failures = [var.proxy_port]
}
