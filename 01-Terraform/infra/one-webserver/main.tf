provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c6e5afdd23291f73"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

<<<<<<< HEAD
  user_data = <<-EOF
							#! /bin/bash
							echo "Hello World" > index.html
							nohup busybox httpd -f -p ${var.server_port} &
							EOF
=======
	user_data = <<-EOF
		    #! /bin/bash
		    echo "Hello World" > index.html
		    nohup busybox httpd -f -p 8080 &
		    EOF
>>>>>>> e943efadca020c5ec02cdf5a2ec173ff19043708

  tags = {
    Name = "aws03-example"
  }
}

resource "aws_security_group" "instance" {
  name = "aws03-terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The pulbic IP of the Example Instance"
}

variable "server_port" {
  description = "The port will use for HTTP requests"
  type        = number
}
