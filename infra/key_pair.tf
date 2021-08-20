resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.kp_aws_user
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/${var.kp_awslab_file_name}.pem"
  file_permission = "0400"
}