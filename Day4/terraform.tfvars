aws_region          = "us-east-1"
vpc_name            = "First"
vpc_cidr_block      = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidr = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
availability_zone   = ["us-east-1a", "us-east-1b", "us-east-1c"]
rt_cidr_block       = "0.0.0.0/0"
ingress_rules = [
  {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  },
  {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  },
  {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }
]
