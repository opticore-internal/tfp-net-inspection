resource "aws_security_group_rule" "flow2_ingress" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  type              = "ingress"
  from_port         = 2222
  to_port           = 2222
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.dev-inspection.nlb_sg_id
}

resource "aws_lb_target_group" "flow2_tg" {
  count       = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  name        = "flow2-tg"
  port        = 2222
  protocol    = "TCP"
  vpc_id      = module.dev-inspection.vpc_id
  target_type = "ip"
  health_check {
    interval            = 30
    port                = "22"
    protocol            = "TCP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "flow2_listener" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  load_balancer_arn = module.dev-inspection.nlb_arn
  port              = 2222
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flow2_tg[0].arn
  }
}

resource "aws_lb_target_group_attachment" "flow2_attach" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  target_group_arn  = aws_lb_target_group.flow2_tg[0].arn
  target_id         = module.dev-inspection.spoke2_instance_private_ip
  availability_zone = module.dev-inspection.spoke2_instance_az
}

