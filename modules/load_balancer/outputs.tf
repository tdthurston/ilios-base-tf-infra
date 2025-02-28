output "lb_name" {
  value = aws_lb.ilios_alb.name
}

output "target_group_name" {
  value = aws_lb_target_group.ilios_alb_tg.name
}

output "lb_dns_name" {
  value = aws_lb.ilios_alb.dns_name
}

output "instance_name" {
  value = aws_instance.ilios_instance.name
}