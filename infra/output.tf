output "ec2_public_ip_awslab" {
  value = aws_instance.public_instance_awslab.*.public_ip
}
output "bucket_arn" {
  value = local.awslab_s3_lambda_trigger.bucket_arn
}