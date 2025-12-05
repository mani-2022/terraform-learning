provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-0709"
    key    = "env/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my_vpc"
  }
}
resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = each.value
  availability_zone       = var.availability_zones[tonumber(replace(each.key, "subnet", "")) - 1]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-${each.key}"
  }
}
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "public_rt"
  }
}
resource "aws_route" "my_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.rt_cidr_block
  gateway_id             = aws_internet_gateway.my_igw.id
}
resource "aws_route_table_association" "my-rt-association" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.sg_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.sg_cidr_blocks
  }
  tags = {
    Name = "my-sg"
  }
}
resource "aws_instance" "my_instance" {
  for_each                    = aws_subnet.public
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = each.value.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  associate_public_ip_address = true
  depends_on                  = [aws_route_table_association.my-rt-association]
  tags = {
    Name = "my_instance"
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    echo "<h1>${var.env}-Server-1</h1>" | sudo tee /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}
