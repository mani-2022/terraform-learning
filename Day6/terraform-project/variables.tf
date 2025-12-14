variable "aws_region" {}
variable "vpc_cidr_block" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "availability_zones" {}
variable "instance_type" {}
variable "key_name" {}
variable "environment" {}
variable "amis" {
  type = map(string)
}
variable "app_name" {}
variable "sg_cidr_block" {}
