output "lb_name" {
  value = aws_lb.ilios_alb.name
}

output "lb_arn" {
  value = aws_lb.ilios_alb.arn
}

output "target_group_name" {
  value = aws_lb_target_group.ilios_alb_tg.name
}

output "target_group_arn" {
  value = aws_lb_target_group.ilios_alb_tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.ilios_alb_listener.arn
}