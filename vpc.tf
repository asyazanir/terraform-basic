## vpc.tf
## aws_vpc.vpc
## aws_subnet.subnet_public_1a
## aws_subnet.subnet_public_1b
## aws_main_route_table_association.public
## aws_route_table_association.subnet_public_1a
## aws_route_table_association.subnet_public_1b
## aws_internet_gateway.igw
## aws_route_table.public
## aws_default_network_acl.acl

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC one"
  }
}

resource "aws_subnet" "subnet_public_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnets_cidr_1a
  availability_zone       = var.azs_1a
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1A"
  }
}

resource "aws_subnet" "subnet_public_1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnets_cidr_1b
  availability_zone       = var.azs_1b
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1B"
  }
}

resource "aws_main_route_table_association" "public" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_public_1a" {
  subnet_id      = aws_subnet.subnet_public_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_public_1b" {
  subnet_id      = aws_subnet.subnet_public_1b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public Route"
  }
}

resource "aws_default_network_acl" "acl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  lifecycle {
    ignore_changes = [
      subnet_ids,
    ]
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Network ACL"
  }
}
