provider "aws" {
  region = var.aws_region
}
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc-cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my_vpc"
  }
}
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet-cidr_block
  availability_zone = var.subnet-ag
  tags = {
    Name = "my_subnet"
  }
}
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.rt-cidr_block
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_security_group" "my-sg-group" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = var.sg-cidr-blocks
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = var.sg-cidr-blocks
  }
  tags = {
    Name = "my-sg-group"
  }
}
resource "aws_instance" "my_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my-sg-group.id]
  tags = {
    Name = "my_instance"
  }
}


