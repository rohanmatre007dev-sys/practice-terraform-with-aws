output "vpc" {
  description = "Map of outputs of the VPC module."
  value       = module.vpc
  # sensitive = false # No sensitive module output found
}
