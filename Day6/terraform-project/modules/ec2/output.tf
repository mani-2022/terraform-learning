output "public_instance" {
  value = aws_instance.public[*].id
}
output "public_ip" {
  value = aws_instance.public[*].public_ip
}
