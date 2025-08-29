resource "aws_network_interface" "pafw1_data_eni" {
  count             = var.deploy_pan ? 1 : 0
  subnet_id         = aws_subnet.appliance_subnet_az_0.id
  private_ips       = [cidrhost(aws_subnet.appliance_subnet_az_0.cidr_block, 4)]
  security_groups   = [aws_security_group.pan_data_sg[0].id]
  source_dest_check = false
  description       = "pafw1 data eni"
  tags              = merge(local.tags, { Name = "${local.name}-pafw1-data-eni" })
}

resource "aws_network_interface" "pafw1_mgmt_eni" {
  count            = var.deploy_pan ? 1 : 0
  subnet_id        = aws_subnet.public_subnet_az_0.id
  private_ips      = [cidrhost(aws_subnet.public_subnet_az_0.cidr_block, 5)]
  security_groups  = [aws_security_group.pan_mgmt_sg[0].id]
  description      = "pafw1 mgmt eni"
  tags             = merge(local.tags, { Name = "${local.name}-pan-mgmt-eni-az0" })
}

resource "aws_network_interface" "pafw1_untrust_eni" {
  count           = var.deploy_pan ? 1 : 0
  subnet_id       = aws_subnet.public_subnet_az_0.id
  private_ips     = [cidrhost(aws_subnet.public_subnet_az_0.cidr_block, 4)]
  security_groups = [aws_security_group.pan_untrust_sg[0].id]
  description     = "pafw1 untrust eni"
  tags            = merge(local.tags, { Name = "${local.name}-pafw1-untrust-eni" })
}

resource "aws_instance" "pafw1" {
  count                = var.deploy_pan ? 1 : 0
  ami                  = var.pan_ami
  instance_type        = var.pan_instance_type
  availability_zone    = var.vpc_az_list[0]
  key_name             = var.pan_key_name
  iam_instance_profile = aws_iam_instance_profile.pan_instance_profile[0].name
  user_data            = <<-EOF
  hostname=pafw1
  vmseries-bootstrap-aws-s3bucket=${aws_s3_bucket.pan_bootstrap[0].bucket}
EOF

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.pafw1_data_eni[0].id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.pafw1_mgmt_eni[0].id
  }
  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.pafw1_untrust_eni[0].id
  }

  tags = merge(local.tags, { Name = "pafw1" })

  depends_on = [aws_s3_bucket.pan_bootstrap, aws_s3_object.init_cfg]
}

resource "aws_network_interface" "pafw2_data_eni" {
  count             = var.deploy_pan ? 1 : 0
  subnet_id         = aws_subnet.appliance_subnet_az_1.id
  private_ips       = [cidrhost(aws_subnet.appliance_subnet_az_1.cidr_block, 4)]
  security_groups   = [aws_security_group.pan_data_sg[0].id]
  source_dest_check = false
  description       = "pafw2 data eni"
  tags              = merge(local.tags, { Name = "${local.name}-pafw2-data-eni" })
}

resource "aws_network_interface" "pafw2_mgmt_eni" {
  count           = var.deploy_pan ? 1 : 0
  subnet_id       = aws_subnet.public_subnet_az_1.id
  private_ips     = [cidrhost(aws_subnet.public_subnet_az_1.cidr_block, 5)]
  security_groups = [aws_security_group.pan_mgmt_sg[0].id]
  description     = "pafw2 mgmt eni"
  tags            = merge(local.tags, { Name = "${local.name}-pafw2-mgmt-eni" })
}

resource "aws_network_interface" "pafw2_untrust_eni" {
  count           = var.deploy_pan ? 1 : 0
  subnet_id       = aws_subnet.public_subnet_az_1.id
  private_ips     = [cidrhost(aws_subnet.public_subnet_az_1.cidr_block, 4)]
  security_groups = [aws_security_group.pan_untrust_sg[0].id]
  description     = "pafw2 untrust eni"
  tags            = merge(local.tags, { Name = "${local.name}-pafw2-untrust-eni" })
}

resource "aws_instance" "pafw2" {
  count                = var.deploy_pan ? 1 : 0
  ami                  = var.pan_ami
  instance_type        = var.pan_instance_type
  availability_zone    = var.vpc_az_list[1]
  key_name             = var.pan_key_name
  iam_instance_profile = aws_iam_instance_profile.pan_instance_profile[0].name
  user_data            = <<-EOF
  hostname=pafw2
  vmseries-bootstrap-aws-s3bucket=${aws_s3_bucket.pan_bootstrap[0].bucket}
EOF

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.pafw2_data_eni[0].id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.pafw2_mgmt_eni[0].id
  }
  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.pafw2_untrust_eni[0].id
  }

  tags = merge(local.tags, { Name = "pafw2" })

  depends_on = [aws_s3_bucket.pan_bootstrap, aws_s3_object.init_cfg]
}
