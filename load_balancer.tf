module "ilios_lb" {
  source = "./modules/load_balancer"

  lb_name           = var.lb_name
  target_group_name = var.target_group_name
  vpc_id            = module.ilios_vpc.vpc_id
  subnet_ids        = module.ilios_vpc.public_subnet_ids
  vpc_cidr_block    = var.vpc_cidr_block
  lb_arn            = var.lb_arn
  target_group_arn  = var.target_group_arn
  listener_arn      = var.listener_arn
}

output "lb_dns_name" {
  value = module.ilios_lb.lb_dns_name
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