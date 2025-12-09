resource "aws_security_group" "Demo_security_group" {
  name        = "${var.vpc_name}_SG"
  description = "Demo Security Group"
  vpc_id      = aws_vpc.Demo_VPC.id
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.vpc_name}_SG"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
