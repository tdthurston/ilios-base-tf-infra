module "ilios_lb" {

  source = "git::https://github.com/tdthurston/ilios-base-tf-infra.git//modules/load_balancer"

  lb_name           = var.lb_name
  target_group_name = var.target_group_name
  vpc_id            = module.ilios_vpc.vpc_id
  vpc_cidr_block    = module.ilios_vpc.vpc_cidr_block
  instance_type     = module.ilios_eks_cluster.instance_type
  public_subnet_ids = module.ilios_vpc.public_subnet_ids


}

output "lb_arn" {
  value = module.ilios_lb.lb_arn
}

output "target_group_arn" {
  value = module.ilios_lb.target_group_arn
}

output "listener_arn" {
  value = module.ilios_lb.listener_arn
}

