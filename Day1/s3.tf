resource "aws_s3_bucket" "my_bucket_jaswinihi1603" {
  bucket     = "my-bucket-jaswinihi1603"
  depends_on = [aws_route_table_association.public_rt_association]
  tags = {
    Name        = "my_bucket_jaswinihi1603"
    Environment = "Dev"
  }
}
