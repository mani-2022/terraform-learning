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
variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}
variable "amis" {
  description = "The AMI ID to use for the instance"
  type        = map(string)
}
variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}
variable "environment" {
  description = "The deployment environment (e.g., Dev, Prod)"
  type        = string
}
