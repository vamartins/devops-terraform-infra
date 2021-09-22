data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "public_instance_awslab" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key
  vpc_security_group_ids      = [aws_security_group.awslab-sg-public.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.prefix}-${var.environment}"
    }
  )
}