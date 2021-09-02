data "archive_file" "awslab_lambda_hello_world" {
  type = "zip"

  source_dir  = "${path.module}/awslab_lambda"
  output_path = "${path.module}/hello-world.zip"
}

resource "aws_s3_bucket_object" "awslab_s3_lambda" {
  bucket = module.awslab-s3-bucket.s3_bucket_id
  key    = "hello-world.zip"
  source = data.archive_file.awslab_lambda_hello_world.output_path
  etag = filemd5(data.archive_file.awslab_lambda_hello_world.output_path)
}