resource "aws_security_group" "awslab-sg-public" {
  name        = "awslab-sg-public"
  description = "Allow all outbound traffic and inbound 22/80/443/ICMP/Linux Updates"
  vpc_id      = aws_vpc.main.id

  # Allow inbound SSH
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.public_dest_cidr_block]
  }

  # Allow inbound HTTP
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.public_dest_cidr_block]
  }

  # Allow inbound HTTPS
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.public_dest_cidr_block]
  }

  # Allow inbound ICMP
  ingress {
    from_port   = var.icmp_port
    to_port     = var.icmp_port
    protocol    = "icmp"
    cidr_blocks = [var.public_dest_cidr_block]
  }

  # Allow inbound S.O. UPDATE and UPGRADE
  ingress {
    from_port   = 32768
    to_port     = 61000
    protocol    = "tcp"
    cidr_blocks = [var.public_dest_cidr_block]
  }

  # Outbound ports
  egress {
    from_port   = var.initial_port
    to_port     = var.initial_port
    protocol    = -1
    cidr_blocks = [var.public_dest_cidr_block]
  }

tags = merge(
    local.common_tags,
    {
      Name = "awslab-sg-public"
    }
  )
}