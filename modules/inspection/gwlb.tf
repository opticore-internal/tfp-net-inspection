resource "aws_lb" "gwlb" {
  name                             = "tfp-${var.env}-net-${local.region_code}-gwlb"
  load_balancer_type               = "gateway"
  enable_cross_zone_load_balancing = true
  subnets = [
    aws_subnet.gwlb_subnet_az_0.id,
    aws_subnet.gwlb_subnet_az_1.id
  ]
  tags = merge(local.tags, { Name = "${local.name}-gwlb" })
}

resource "aws_lb_target_group" "gwlb_target_group" {
  name        = "tfp-${var.env}-${local.region_code}-gwlb-targets"
  port        = 6081
  protocol    = "GENEVE"
  vpc_id      = aws_vpc.this.id
  target_type = "ip"
  tags        = merge(local.tags, { Name = "${local.name}-gwlb-tg" })

  health_check {
    enabled             = true
    protocol            = "HTTPS"
    port                = "443"
    path                = "/php/login.php"
    interval            = 5
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  target_failover {
    on_deregistration = "rebalance"
    on_unhealthy      = "rebalance"
  }
}

resource "aws_lb_listener" "gwlb_listener" {
  load_balancer_arn = aws_lb.gwlb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gwlb_target_group.arn
  }
}

resource "aws_vpc_endpoint_service" "gwlb" {
  acceptance_required        = false
  gateway_load_balancer_arns = [aws_lb.gwlb.arn]
  tags                       = merge(local.tags, { Name = "${local.name}-gwlb-svc" })
}
