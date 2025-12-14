terraform {
  backend "s3" {
    bucket = "terraform-aws-demo-bucket-1609"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}
