output "backend_url" {
  value = "http://localhost:5000"
}

output "frontend_url" {
  value = "http://localhost:8000"
}

output "server_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.buzzmart_server.public_ip
}

