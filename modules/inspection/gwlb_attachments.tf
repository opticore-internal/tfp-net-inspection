resource "aws_lb_target_group_attachment" "pafw1" {
  count             = var.deploy_pan ? 1 : 0
  target_group_arn  = aws_lb_target_group.gwlb_target_group.arn
  target_id         = aws_instance.pafw1[0].private_ip
  availability_zone = var.vpc_az_list[0]
  depends_on        = [aws_instance.pafw1]
}

resource "aws_lb_target_group_attachment" "pafw2" {
  count             = var.deploy_pan ? 1 : 0
  target_group_arn  = aws_lb_target_group.gwlb_target_group.arn
  target_id         = aws_instance.pafw2[0].private_ip
  availability_zone = var.vpc_az_list[1]
  depends_on        = [aws_instance.pafw2]
}

