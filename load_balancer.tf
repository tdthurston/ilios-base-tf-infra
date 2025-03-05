module "ilios_lb" {

  source = "./modules/load_balancer"

  lb_name           = var.lb_name
  target_group_name = var.target_group_name
  vpc_id            = module.ilios_vpc.vpc_id
  vpc_cidr_block    = module.ilios_vpc.vpc_cidr_block
  instance_type     = module.ilios_eks_cluster.instance_type
  public_subnet_ids = module.ilios_vpc.public_subnet_ids

}

output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = module.ilios_lb.alb_dns_name
}

output "listener_arn" {
  description = "ARN of the listener for the ALB"
  value       = module.ilios_lb.listener_arn
}

output "target_group_arn" {
  description = "ARN of the target group for the ALB"
  value       = module.ilios_lb.target_group_arn
}

output "lb_arn" {
  description = "ARN of the ALB"
  value       = module.ilios_lb.lb_arn
}