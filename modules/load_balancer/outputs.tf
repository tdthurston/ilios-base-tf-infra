output "alb_name" {
  description = "ALB name"
  value       = aws_lb.ilios_alb.name
}

output "target_group_name" {
  description = "Target Group name"
  value       = aws_lb_target_group.ilios_alb_tg.name
}

output "alb_dns_name" {
  description = "ALB DNS"
  value       = aws_lb.ilios_alb.dns_name
}

output "listener_arn" {
  description = "ARN of the listener for the ALB"
  value       = module.ilios_lb.listener_arn
}

output "target_group_arn" {
  description = "ARN of the target group for the ALB"
  value       = module.ilios_lb.target_group_arn
}