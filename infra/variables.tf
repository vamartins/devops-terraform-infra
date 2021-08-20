locals {
  # Common tags to be assigned to all resources
  common_tags = {
    service_name = "Curso Terraform"
    owner        = "Vagner Almeida Martins"
    provisioner  = "Terraform"
  }
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
variable "iam_ro_policy" {
  type        = string
  description = "IAM Read-Only Policy for TUI User"
}