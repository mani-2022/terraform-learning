provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "Demo_VPC" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name        = "Demo_VPC"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
resource "aws_subnet" "Public_Subnet" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.Demo_VPC.id
  cidr_block        = element(var.public_subnet_cidr, count.index + 1)
  availability_zone = element(var.availability_zone, count.index + 1)
  tags = {
    Name        = "${var.vpc_name}_Public_Subnet_${count.index + 1}"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
resource "aws_subnet" "Private_Subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.Demo_VPC.id
  cidr_block        = element(var.private_subnet_cidr, count.index + 1)
  availability_zone = element(var.availability_zone, count.index + 1)
  tags = {
    Name        = "${var.vpc_name}_Private_Subnet_${count.index + 1}"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
resource "aws_internet_gateway" "Demo_IGW" {
  vpc_id = aws_vpc.Demo_VPC.id
  tags = {
    Name        = "${var.vpc_name}_IGW"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
resource "aws_route_table" "Demo_Public_Route_Table" {
  vpc_id = aws_vpc.Demo_VPC.id
  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.Demo_IGW.id
  }
  tags = {
    Name        = "Demo_Public_Route_Table"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
resource "aws_route_table" "Demo_Private_Route_Table" {
  vpc_id = aws_vpc.Demo_VPC.id
  tags = {
    Name        = "Demo_Private_Route_Table"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
resource "aws_route_table_association" "Public_Route_Table_Association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.Public_Subnet[count.index].id
  route_table_id = aws_route_table.Demo_Public_Route_Table.id
}
resource "aws_route_table_association" "Private_Route_Table_Association" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.Private_Subnet[count.index].id
  route_table_id = aws_route_table.Demo_Private_Route_Table.id
}
