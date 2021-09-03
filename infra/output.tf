output "ec2_public_ip_awslab" {
  value = aws_instance.public_instance_awslab.*.public_ip
}
output "bucket_arn" {
  value = module.awslab-s3-lambda-trigger.s3_bucket_arn
}