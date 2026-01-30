# -------------------
# Docker Network
# -------------------
# Managed by Terraform
resource "docker_network" "mern_network" {
  name   = "mern-network"
  driver = "bridge"
}

# -------------------
# Notes
# -------------------
# Application deployment is now handled by Ansible + Docker Compose.
# Terraform is reserved for future infrastructure provisioning (e.g. AWS EC2, Security Groups, etc.)

