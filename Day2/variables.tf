variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}
variable "public_subnets" {
  description = "A map of public subnet CIDR blocks."
  type        = map(string)
}
variable "availability_zones" {
  description = "A list of availability zones to use for the subnets."
  type        = list(string)
}
variable "rt_cidr_block" {
  description = "The destination CIDR block for the route table."
  type        = string
}
variable "sg_cidr_blocks" {
  description = "A list of CIDR blocks for the security group rules."
  type        = list(string)
}
variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}
variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}
variable "key_name" {
  description = "The key pair name for SSH access to the EC2 instance."
  type        = string
}
variable "env" {
  description = "The environment for resource tagging."
  type        = string
}
