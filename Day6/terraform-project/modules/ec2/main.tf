resource "aws_instance" "public" {
  count                       = length(var.public_subnet_ids)
  subnet_id                   = var.public_subnet_ids[count.index]
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_public_id]
  key_name                    = var.key_name

  user_data = templatefile("${path.module}/userdata.sh", {
    env      = var.environment
    app_name = var.app_name
  })
  user_data_replace_on_change = true

  tags = {
    Name = "${var.environment}-public-instance-${count.index + 1}"
  }
}

resource "aws_instance" "private" {
  count                  = length(var.private_subnet_ids)
  subnet_id              = var.private_subnet_ids[count.index]
  ami                    = lookup(var.amis, var.aws_region)
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.sg_private_id]

  tags = {
    Name = "${var.environment}-private-instance-${count.index + 1}"
  }

}


