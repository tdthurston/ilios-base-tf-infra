module "ilios_eks_cluster" {

  source = "./modules/eks"

  cluster_name                 = var.cluster_name
  node_group_name              = var.node_group_name
  cluster_security_group_id    = module.vpc.vpc_default_security_group_id
  node_group_security_group_id = module.vpc.vpc_default_security_group_id
  instance_type                = var.instance_type
  desired_capacity             = var.desired_capacity
  min_size                     = var.min_size
  max_size                     = var.max_size
  max_unavailable              = var.max_unavailable

}

output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.ilios_eks_cluster.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.ilios_eks_cluster.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster"
  value       = module.ilios_eks_cluster.cluster_security_group_id
}

output "node_group_role_arn" {
  description = "The ARN of the node group role"
  value       = module.ilios_eks_cluster.node_group_role_arn
}