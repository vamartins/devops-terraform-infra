output "ec2_public_ip_awslab" {
  value = aws_instance.public_instance_awslab.*.public_ip
}

output "s3_awslab" {
  value = module.awslab-s3-bucket.s3_bucket_id
}