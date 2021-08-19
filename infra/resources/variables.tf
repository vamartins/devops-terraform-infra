variable "region" {
  type        = string
  description = "Region where resources are going to be deployed"
}

variable "az" {
  type        = string
  description = "AZ for subnets inside VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for VPC"
}

variable "subnet_public_cidr" {
  type        = string
  description = "CIDR for public subnet"
}

variable "public_dest_cidr_block" {
  type        = string
  description = "CIDR for public destination"
}

variable "sg_public_ports" {
  type        = string
  description = "Name for Public Security Group Traffic"
}

variable "http_port" {
  type        = string
  description = "HTTP port"
}

variable "https_port" {
  type        = string
  description = "HTTPS port"
}

variable "ssh_port" {
  type        = string
  description = "SSH port"
}

variable "icmp_port" {
  type        = string
  description = "ICMP port"
}

variable "initial_port" {
  type        = string
  description = "Initial port"
}

variable "final_port" {
  type        = string
  description = "Final port"
}

variable "tcp_protocol" {
  type        = string
  description = "TCP Protocol"
}

variable "icmp_protocol" {
  type        = string
  description = "ICMP Protocol"
}

variable "all_protocols" {
  type        = string
  description = "All Protocols"
}

variable "tui_user" {
  type        = string
  description = "IAM user"
}

variable "iam_ro_policy" {
  type        = string
  description = "IAM Read-Only Policy for awslab User"
}

variable "kp_aws_user" {
  type        = string
  description = "Key-Pair for awslab User"
}

variable "instance_type" {
  type        = string
  description = "Instance type for EC2"
}

variable "awslab_user" {
  type        = string
  description = "User owner for .PEM file"
}