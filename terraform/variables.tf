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

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair in AWS"
  type        = string
  default     = "buzzmart-key"
}
