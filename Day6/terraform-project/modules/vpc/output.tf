output "vpc_id" {
  value = aws_vpc.my-vpc.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}
output "igw" {
  value = aws_internet_gateway.my-igw.id

}
output "route_table_id" {
  value = aws_route_table.my_public_rt.id
}
