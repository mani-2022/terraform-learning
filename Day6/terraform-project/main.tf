module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  environment        = var.environment
}

module "sg" {
  source = "./modules/securitygroup"
  vpc_id = module.vpc.vpc_id

  sg_cidr_block = var.sg_cidr_block
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
}

module "ec2" {
  source             = "./modules/ec2"
  sg_public_id       = module.sg.sg_public_id
  sg_private_id      = module.sg.sg_private_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  instance_type      = var.instance_type[var.environment]
  environment        = var.environment
  key_name           = var.key_name
  amis               = var.amis
  aws_region         = var.aws_region
  app_name           = var.app_name
}


