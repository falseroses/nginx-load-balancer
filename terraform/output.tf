output "frontend_webserv_public_ip" {
  value = aws_instance.my_frontend_webserv.public_ip
}