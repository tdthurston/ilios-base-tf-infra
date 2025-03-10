resource "aws_lb" "ilios_alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnet_ids
  tags               = var.tags


  enable_deletion_protection = false
}

resource "aws_lb_target_group" "ilios_alb_tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }

  tags = var.tags
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ilios_alb_instance" {

  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.lb_sg.id]
  ami                    = data.aws_ami.latest_amazon_linux.id
  tags                   = var.tags

}

resource "aws_lb_target_group_attachment" "ilios_alb_tga" {
  target_group_arn = aws_lb_target_group.ilios_alb_tg.arn
  target_id        = aws_instance.ilios_alb_instance.id
  port             = 80
}

resource "aws_lb_listener" "ilios_alb_listener" {
  load_balancer_arn = aws_lb.ilios_alb.arn
  port              = 80
  protocol          = "HTTP"
  tags              = var.tags

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ilios_alb_tg.arn
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "ilios-lb-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "lb_sg_rule_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = aws_security_group.lb_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
}

resource "aws_security_group_rule" "lb_sg_rule_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.lb_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
}