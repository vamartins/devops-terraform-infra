output "ec2_public_ip_awslab" {
  value = aws_instance.public_instance_awslab.*.public_ip
}