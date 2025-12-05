aws_region     = "ap-south-1"
vpc_cidr_block = "10.0.0.0/16"
public_subnets = {
  subnet1 = "10.0.3.0/24"
  subnet2 = "10.0.4.0/24"
}
availability_zones = ["ap-south-1a", "ap-south-1b"]
rt_cidr_block      = "0.0.0.0/0"
sg_cidr_blocks     = ["0.0.0.0/0"]
ami_id             = "ami-02b8269d5e85954ef"
instance_type      = "t2.micro"
key_name           = "3-tier"
env                = "stage"
