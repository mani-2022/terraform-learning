output "sg_public_id" {
  value = aws_security_group.my-public-sg.id
}

output "sg_private_id" {
  value = aws_security_group.my-private-sg.id
}

