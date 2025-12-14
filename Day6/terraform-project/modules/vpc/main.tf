resource "aws_vpc" "my-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.environment}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.environment}-private-subnet-${count.index + 1}"
  }
}
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
}
resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}
resource "aws_route_table_association" "my-my_public_rt_association" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.my_public_rt.id
}
resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my-vpc.id
}
resource "aws_route_table_association" "my-my_private_rt_association" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.my_public_rt.id
}
