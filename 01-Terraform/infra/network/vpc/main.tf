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

resource "aws_internet_gateway" "aws03_igw" {
	vpc_id = aws_vpc.aws03_vpc.id

	tags = {
		Name = "aws03-internet-gateway"
	}
}

resource "aws_eip" "aws03_eip" {
	vpc = true
	depends_on = ["aws_internet_gateway.aws03_igw"]
	lifecycle  {
		create_before_destroy = true
	}
}

resource "aws_nat_gateway" "aws03_nat" {
	allocation_id = aws_eip.aws03_eip.id
	subnet_id = aws_subnet.aws03_public_subnet2a.id
	depends_on = ["aws_internet_gateway.aws03_igw"]
	tags = {
		Name = "aws03-nat"
	}
}

resource "aws_default_route_table" "aws03_public_rt" {
	default_route_table_id = aws_vpc.aws03_vpc.default_route_table_id

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.aws03_igw.id
	}
	tags = {
		Name = "aws03_public_route_table"
	}
}

resource "aws_route_table_association" "aws03_public_rta_2a" {
	subnet_id = aws_subnet.aws03_public_subnet2a.id
	route_table_id = aws_default_route_table.aws03_public_rt.id
}


resource "aws_route_table_association" "aws03_public_rta_2c" {
	subnet_id = aws_subnet.aws03_public_subnet2c.id
	route_table_id = aws_default_route_table.aws03_public_rt.id
}

resource "aws_route_table" "aws03_private_rt" {
	vpc_id = aws_vpc.aws03_vpc.id
	tags = {
		Name = "aws03_private_route_table"
	}
}

resource "aws_route_table_association" "aws03_private_rta_2a" {
	subnet_id = aws_subnet.aws03_private_subnet2a.id
	route_table_id = aws_route_table.aws03_private_rt.id
}

resource "aws_route_table_association" "aws03_private_rta_2c" {
	subnet_id = aws_subnet.aws03_private_subnet2c.id
	route_table_id = aws_route_table.aws03_private_rt.id
}

resource "aws_route" "private_rt_table" {
	route_table_id = aws_route_table.aws03_private_rt.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = aws_nat_gateway.aws03_nat.id
}
