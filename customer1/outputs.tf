output "vpc_name" {
  description = "The name for the created VPC."
  value       = module.vpc.name
}
output "vpc_id" {
  description = "The ID for the created VPC."
  value       = module.vpc.vpc_id
}
output "private_subnets" {
  description = "The list for the private subnets."
  value       = module.vpc.private_subnets
}

output "eks-cluster-name" {
  value = module.eks_cluster.cluster_arn
}

/*output "vault_endpoint_securitygroup" {
  description = "AWS Security Group ID of Vault endpoint."
  value       = aws_security_group.vault_endpoint.id
}*/
