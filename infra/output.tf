output "key_name" {
  value       = try(aws_key_pair.generated[0].key_name, "")
  description = "Name of SSH key"
}

output "public_key" {
  value       = try(aws_key_pair.generated[0].public_key, tls_private_key.ssh[0].public_key_openssh, "")
  description = "Content of the generated public key"
}

output "private_key" {
  sensitive   = true
  description = "Content of the generated private key"
  value       = join("", tls_private_key.ssh.*.private_key_pem)
}