resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = "my-s3-bucket-terraform-000"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}