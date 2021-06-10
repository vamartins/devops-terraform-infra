resource "aws_s3_bucket" "bucket" {
  bucket = "vagner-samm"
  acl    = "private"

  tags = local.common_tags
}