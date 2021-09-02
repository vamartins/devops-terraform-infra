######
# Lambda module placeholder
######
##All the names provided are examples, adjust for each Lambda
module "awslab-lambda-function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "2.16.0"
  
  source_path = "../../src/local.awslab_lambda"

  handler     = local.awslab_lambda.handler
  name        = local.awslab_lambda.name
  runtime     = local.awslab_lambda.runtime
  memory_size = local.awslab_lambda.memory_size
  timeout     = local.awslab_lambda.timeout
  npm_install = true
  npm_build   = true
  lambda_src  = local.awslab_lambda

  lambda_role_name = "${local.awslab_lambda.name}-role"
  tracing_mode     = "Active"
  tags = merge(local.common_tags,
    {
      Name : local.awslab_lambda.name
    }
  )
}

data "template_file" "awslab-lambda-policy" {
  template = file("../policies/awslab_lamdba_policy.tpl")
  vars = {
    s3_arn     = module.awslab-s3-bucket.bucket_arn
  }
}