variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "instance_type" {
  type = string
}
variable "environment" {}
variable "key_name" {
  type = string
}
variable "amis" {
  type = map(string)
}
variable "aws_region" {}
variable "sg_public_id" {
  type = string
}

variable "sg_private_id" {
  type = string
}
variable "app_name" {
  type = string
}
