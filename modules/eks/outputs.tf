output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "node_group_security_group_id" {
  value = module.eks.node_group_security_group_id
}

output "node_group_role_arn" {
  value = module.eks.node_group_role_arn
}

output "cluster_role_arn" {
  value = module.eks.cluster_role_arn
}