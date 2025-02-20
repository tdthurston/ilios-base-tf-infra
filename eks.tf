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