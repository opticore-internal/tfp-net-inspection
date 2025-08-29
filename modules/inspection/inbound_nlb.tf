resource "aws_security_group" "nlb_sg" {
  count       = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  name        = "nlb-sg"
  description = "Allow all traffic for NLB"
  vpc_id      = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.tags, { Name = "${local.name}-nlb-sg" })
}

resource "aws_security_group_rule" "flow1_ingress" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  type              = "ingress"
  from_port         = var.spoke1_target_port
  to_port           = var.spoke1_target_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg[0].id
}

resource "aws_security_group_rule" "flow2_ingress" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  type              = "ingress"
  from_port         = var.spoke2_target_port
  to_port           = var.spoke2_target_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg[0].id
}

resource "aws_lb" "nlb" {
  count              = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  name               = "inbound-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb_sg[0].id]
  subnets            = [aws_subnet.public_subnet_az_0.id, aws_subnet.public_subnet_az_1.id]
  tags               = merge(local.tags, { Name = "${local.name}-inbound-nlb" })
}

resource "aws_lb_target_group" "flow1_tg" {
  count       = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  name        = "flow1-tg"
  port        = var.spoke1_target_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.this.id
  target_type = "ip"
  preserve_client_ip = false
  tags        = merge(local.tags, { Name = "${local.name}-flow1-tg" })
  health_check {
    interval            = 30
    port                = "22"
    protocol            = "TCP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "flow1_listener" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  load_balancer_arn = aws_lb.nlb[0].arn
  port              = var.spoke1_target_port
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flow1_tg[0].arn
  }
}

resource "aws_lb_target_group_attachment" "flow1_attach" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  target_group_arn  = aws_lb_target_group.flow1_tg[0].arn
  target_id         = aws_instance.test_vm_spoke1[0].private_ip
  availability_zone = aws_instance.test_vm_spoke1[0].availability_zone
}

resource "aws_lb_target_group" "flow2_tg" {
  count       = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  name        = "flow2-tg"
  port        = var.spoke2_target_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.this.id
  target_type = "ip"
  preserve_client_ip = false
  tags        = merge(local.tags, { Name = "${local.name}-flow2-tg" })
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
  load_balancer_arn = aws_lb.nlb[0].arn
  port              = var.spoke2_target_port
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flow2_tg[0].arn
  }
}

resource "aws_lb_target_group_attachment" "flow2_attach" {
  count             = (var.deploy_nlb && var.deploy_spokes) ? 1 : 0
  target_group_arn  = aws_lb_target_group.flow2_tg[0].arn
  target_id         = aws_instance.test_vm_spoke2[0].private_ip
  availability_zone = aws_instance.test_vm_spoke2[0].availability_zone
}
