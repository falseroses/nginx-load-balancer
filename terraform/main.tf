provider "aws" {
  region                  = var.aws_region
}

resource "aws_instance" "frontend_webserv" {
  count = 2
  ami           = "ami-07df274a488ca9195"
  instance_type = "t2.micro"
  key_name      = "falseroses-key-Frankfurt"
  vpc_security_group_ids = [aws_security_group.webserv_security_group.id]

  tags = {
    Name = "frontend_webserv_${count.index}"
  }
}

resource "aws_instance" "load_balancer" {
  ami           = "ami-07df274a488ca9195"
  instance_type = "t2.micro"
  key_name      = "falseroses-key-Frankfurt"
  vpc_security_group_ids = [aws_security_group.webserv_security_group.id]

  tags = {
    Name = "load_balancer"
  }
}

resource "aws_security_group" "webserv_security_group" {
  name        = "WebServer Security Group"
  description = "WebServer Security Group"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name   = "webserv_security_group"
  }
}