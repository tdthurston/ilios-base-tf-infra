provider "kubernetes" {
  host                   = module.ilios_eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.ilios_eks_cluster.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      module.ilios_eks_cluster.cluster_name,
      "--region",
      var.aws_region
    ]
  }
}

module "ilios_eks_cluster" {
  source = "./modules/eks"
  
  cluster_name                 = var.cluster_name
  node_group_name              = var.node_group_name
  # Remove circular dependencies
  cluster_security_group_id    = null
  node_group_security_group_id = null
  instance_type                = var.instance_type
  desired_capacity             = var.desired_capacity
  min_size                     = var.min_size
  max_size                     = var.max_size
  max_unavailable              = var.max_unavailable
  vpc_id                       = module.ilios_vpc.vpc_id
  private_subnet_ids           = module.ilios_vpc.private_subnet_ids
  
  # Add OIDC role for GitHub Actions
  aws_auth_roles = [
    {
      rolearn  = module.ilios_oidc.oidc_role_arn
      username = "github-actions"
      groups   = ["system:masters"]
    }
  ]
}

output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.ilios_eks_cluster.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.ilios_eks_cluster.cluster_endpoint
}

output "instance_type" {
  description = "The instance type of the EKS cluster"
  value       = var.instance_type
}

output "cluster_ca_certificate" {
  description = "The CA certificate of the EKS cluster"
  value       = module.ilios_eks_cluster.cluster_ca_certificate
  sensitive   = true
}

output "irsa_role_arn" {
  description = "ARN of the IRSA role"
  value       = module.ilios_eks_cluster.irsa_role_arn
}