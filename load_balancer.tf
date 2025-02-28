module "ilios_lb" {

  source = "git::https://github.com/tdthurston/ilios-base-tf-infra.git//modules/load_balancer"

  lb_name           = var.lb_name
  target_group_name = var.target_group_name
  instance_name     = var.instance_name
  vpc_id            = module.ilios_vpc.vpc_id
  vpc_cidr_block    = module.ilios_vpc.vpc_cidr_block
  instance_type     = module.ilios_eks_cluster.instance_type
  public_subnet_ids = module.ilios_vpc.public_subnet_ids

}

output "instance_name" {
  description = "Instance Name"
  value       = module.ilios_lb.instance_name
}

output "lb_dns_name" {
  description = "ALB DNS Name"
  value       = module.ilios_lb.lb_dns_name
}

