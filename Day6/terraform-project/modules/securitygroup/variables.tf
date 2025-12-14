variable "sg_cidr_block" {
  type = list(string)
}
variable "vpc_id" {}
variable "ingress_rules" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}
