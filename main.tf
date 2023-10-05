provider "aws" {
  region     = "us-east-1"
  access_key = var.secrets.access_key
  secret_key = var.secrets.secret_key
}

# 1. create VPC
resource "aws_vpc" "pro-vpn" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name : "production"
  }
}

# 2. create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.pro-vpn.id

  tags = {
    Name : "prod-gateway"
  }
}

# 3. create custom route table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.pro-vpn.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod-router"
  }
}

# 4. create a subnet
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.pro-vpn.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-la"

  tags = {
    Name : "prod-subnet"
  }
}

# 5. associate route table with subnet
resource "aws_route_table_association" "association-1" {
  route_table_id = aws_route_table.prod-route-table.id
  subnet_id      = aws_subnet.subnet-1.id
}

# create security group to allow