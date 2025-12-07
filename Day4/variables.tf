variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "public_subnet_cidr" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}
variable "private_subnet_cidr" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}
variable "availability_zone" {
  description = "The availability zone for the subnets"
  type        = list(string)
}
variable "rt_cidr_block" {
  description = "The CIDR block for the route table"
  type        = string
}
variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}
