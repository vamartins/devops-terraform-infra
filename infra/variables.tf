locals {
  # Common tags to be assigned to all resources
  common_tags = {
    service_name = "Curso Terraform"
    owner        = "Vagner Almeida Martins"
    provisioner  = "Terraform"
  }
}

variable "region" {
  description = "Define what region the resources will be deployed"
  default     = "us-east-2"
}