resource "aws_vpc" "aws03_vpc" {
	cidr_block = var.vpc_cidr
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"

	tags = {
		Name = "aws03_vpc"
	}
}

resource "aws_subnet" "aws03_public_subnet2a"{
	vpc_id = aws_vpc.aws03_vpc.id
	cidr_block = var.public_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "aws03-public-subnet2a"
	}
}

resource "aws_subnet" "aws03_public_subnet2c"{
	vpc_id = aws_vpc.aws03_vpc.id
	cidr_block = var.public_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "aws03-public-subnet2c"
	}
}

resource "aws_subnet" "aws03_private_subnet2a"{
	vpc_id = aws_vpc.aws03_vpc.id
	cidr_block = var.private_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "aws03-private-subnet2a"
	}
}

resource "aws_subnet" "aws03_private_subnet2c"{
	vpc_id = aws_vpc.aws03_vpc.id
	cidr_block = var.private_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "aws03-private-subnet2c"
	}
}