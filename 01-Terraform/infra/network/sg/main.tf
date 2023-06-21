/* resource "aws_default_security_group" "aws03_default_sg" {
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
        ingress {
        protocol = "tcp"
        from_port = 0
        to_port = 65535
        cidr_blocks = [data.terraform_remote_state.aws03_vpc.outputs.vpc_cidr]
    }

    egress {
            protocol = "-1"
            from_port = 0
            to_port = 0
            cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "aws03-default-sg"
        Destciption = "aws03 default security group"
    }
}
*/

resource "aws_security_group" "aws03_ssh_sg" {
  name        = "aws03_ssh_sg"
  description = "aws03 security group"
  vpc_id      = data.terraform_remote_state.aws03_vpc.outputs.vpc_id

  ingress {
    description = "for ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aws03_ssh_sg"
  }
}

resource "aws_security_group" "aws03_web_sg" {
  name        = "aws03_web_sg"
  description = "aws03 web group"
  vpc_id      = data.terraform_remote_state.aws03_vpc.outputs.vpc_id

  ingress {
    description = "for web port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aws03_web_sg"
  }
}
