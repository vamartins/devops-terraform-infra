module "awslab-s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.9.0"

  bucket                                = local.awslab_s3.bucket_name
  acl                                   = "private"
  attach_deny_insecure_transport_policy = true
  block_public_acls                     = true
  block_public_policy                   = true
  ignore_public_acls                    = true
  restrict_public_buckets               = true
  versioning = {
    enabled = false
  }
  tags = merge(local.common_tags,
    {
      Name : local.awslab_s3.bucket_name
    }
  )
}

# resource "aws_lambda_permission" "allow_bucket" {
#   statement_id  = "AllowExecutionFromS3Bucket"
#   action        = "lambda:InvokeFunction"
#   function_name = module.awslab-lambda-function.arn
#   principal     = "s3.amazonaws.com"
#   source_arn    = module.awslab-s3-bucket.bucket_arn
# }

# resource "aws_s3_bucket_notification" "bucket_notification" {
#   bucket = module.awslab-s3-bucket.bucket_name

#   lambda_function {
#     lambda_function_arn = module.awslab-lambda-function.arn
#     events = [
#     "s3:ObjectCreated:*"]
#   }

#   depends_on = [
#   aws_lambda_permission.allow_bucket]
# }