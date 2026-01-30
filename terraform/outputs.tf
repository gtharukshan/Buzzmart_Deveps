output "backend_url" {
  value = "http://localhost:5000"
}

output "frontend_url" {
  value = "http://localhost:8000"
}

# Removed mongo_port output as the container is no longer managed by Terraform
