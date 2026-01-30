variable "project_root" {
  description = "Path to the project root directory"
  type        = string
  default     = "../"
}

variable "docker_host" {
  description = "Docker daemon socket"
  type        = string
  default     = "unix:///home/tharuk/.docker/desktop/docker.sock"
}

# Removed application-specific variables as they are now managed by docker-compose

