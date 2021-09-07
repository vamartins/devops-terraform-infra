locals {

  prefix = "${var.project_code}-${var.application_name}"
  # Common tags to be assigned to all resources
  common_tags = {
    service_name = "Curso Terraform"
    owner        = "Vagner Almeida Martins"
    provisioner  = "Terraform"
  }

  awslab_s3_lambda_archive = {
    bucket_name = "${local.prefix}-${var.environment}-lambda-archive"
  }

  awslab_s3_lambda_trigger = {
    bucket_name = "${local.prefix}-${var.environment}-lambda-trigger"
  }

  awslab_lambda = {
    name        = "${local.prefix}-${var.environment}-lambda"
    handler     = "index.handler"
    runtime     = "nodejs14.x"
    memory_size = 128
    timeout     = 900
  }

  lambda_path = "${path.module}/lambda"
  layer_path  = "${path.module}/layer"
}

variable "environment" {
  type = string
}

variable "project_code" {
  type = string
}

variable "application_name" {
  type = string
}

variable "public_dest_cidr_block" {
  type        = string
  description = "CIDR for public destination"
  default     = "0.0.0.0/0"
}

variable "http_port" {
  type        = string
  description = "HTTP port"
  default     = "80"
}

variable "https_port" {
  type        = string
  description = "HTTPS port"
  default     = "443"
}

variable "ssh_port" {
  type        = string
  description = "SSH port"
  default     = "22"
}

variable "icmp_port" {
  type        = string
  description = "ICMP port"
  default     = "-1"
}

variable "initial_port" {
  type        = string
  description = "Initial port"
  default     = "0"
}

variable "final_port" {
  type        = string
  description = "Final port"
  default     = "65535"
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_public_cidr" {
  type = string
}

variable "az" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key" {
  type        = string
  description = "key pairs used in EC2 instances"
  default     = "challenge_tui"
}
