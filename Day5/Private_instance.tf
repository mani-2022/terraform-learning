resource "aws_instance" "Demo_Private_Instance" {
  count                  = var.environment == "Prod" ? 3 : 1
  ami                    = lookup(var.amis, var.aws_region)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.Private_Subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.Demo_security_group.id]
  key_name               = var.key_name
  tags = {
    Name        = "${var.vpc_name}_Private_Instance-${count.index + 1}"
    Owner       = "locals.Owner"
    Team        = "locals.Team"
    Environment = "locals.environment"
  }
}
