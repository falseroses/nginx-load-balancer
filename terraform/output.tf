output "frontend_webserv_public_ip" {
  value = ["${aws_instance.frontend_webserv.*}"]
}