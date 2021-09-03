data "archive_file" "awslab_lambda_archive" {
  type = "zip"

  source_dir  = "${path.module}/awslab_lambda"
  output_path = "${path.module}/hello-world.zip"
}

resource "aws_s3_bucket_object" "awslab_s3_lambda" {
  bucket = module.awslab-s3-lambda-archive.s3_bucket_id
  key    = "hello-world.zip"
  source = data.archive_file.awslab_lambda_archive.output_path
  etag = filemd5(data.archive_file.awslab_lambda_archive.output_path)
}


resource "aws_lambda_function" "awslab_lambda_hello_world" {
  function_name = local.awslab_lambda.name
  runtime = local.awslab_lambda.runtime
  handler = local.awslab_lambda.handler
  memory_size = local.awslab_lambda.memory_size
  timeout = local.awslab_lambda.timeout
  s3_bucket = module.awslab-s3-lambda-archive.s3_bucket_id
  s3_key    = aws_s3_bucket_object.awslab_s3_lambda.key
  source_code_hash = data.archive_file.awslab_lambda_archive.output_base64sha256
  role = aws_iam_role.lambda_exec.arn
  tags = merge(local.common_tags,
    {
      Name : local.awslab_lambda.name
    }
  )
}

resource "aws_cloudwatch_log_group" "hello_world" {
  name = "/aws/lambda/${aws_lambda_function.awslab_lambda_hello_world.function_name}"
  retention_in_days = 1
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid    = ""
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy     = data.template_file.awslab-lambda-policy.rendered
}

data "template_file" "awslab-lambda-policy" {
  template = "${path.module}/policies/awslab_lamdba_policy.tpl"
  vars = {
    s3_arn     = module.awslab-s3-lambda-trigger.s3_bucket_arn
  }
}
