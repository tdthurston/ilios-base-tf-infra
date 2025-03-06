output "cluster_name" {
  description = "EKS Cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "EKS Cluster security group ID"
  value       = module.eks.cluster_security_group_id
}

output "node_group_security_group_id" {
  description = "EKS Node Group security group ID"
  value       = module.eks.node_security_group_id
}

output "node_group_role_arn" {
  description = "EKS Node Group role ARN"
  value       = module.eks.eks_managed_node_groups["main"].iam_role_arn
}

output "cluster_role_arn" {
  description = "EKS Cluster role ARN"
  value       = module.eks.cluster_iam_role_arn
}

output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "instance_type" {
  description = "EKS cluster instance type"
  value       = var.instance_type
}

output "cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "irsa_role_arn" {
  description = "ARN of the IRSA role"
  value       = module.eks.oidc_provider_arn
}