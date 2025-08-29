locals {
  spoke1_subnet_cidr = cidrsubnet(var.spoke1_cidr, 4, 0) # /28 from /24 by default
  spoke2_subnet_cidr = cidrsubnet(var.spoke2_cidr, 4, 0)
}

resource "aws_vpc" "spoke1" {
  count      = var.deploy_spokes ? 1 : 0
  cidr_block = var.spoke1_cidr
  tags       = merge(local.tags, { Name = "${local.name}-spoke1-vpc" })
}

resource "aws_subnet" "spoke1_subnet" {
  count             = var.deploy_spokes ? 1 : 0
  vpc_id            = aws_vpc.spoke1[0].id
  cidr_block        = local.spoke1_subnet_cidr
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-spoke1-subnet" })
}

resource "aws_route_table" "spoke1_rt" {
  count = var.deploy_spokes ? 1 : 0
  vpc_id = aws_vpc.spoke1[0].id
  tags   = merge(local.tags, { Name = "${local.name}-spoke1-rt" })
}

resource "aws_route_table_association" "spoke1_assoc" {
  count         = var.deploy_spokes ? 1 : 0
  subnet_id     = aws_subnet.spoke1_subnet[0].id
  route_table_id = aws_route_table.spoke1_rt[0].id
}

resource "aws_route" "spoke1_to_tgw" {
  count                 = var.deploy_spokes ? 1 : 0
  route_table_id         = aws_route_table.spoke1_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

resource "aws_security_group" "test_vm_sg_spoke1" {
  count       = var.deploy_spokes ? 1 : 0
  name        = "test-vm-sg-spoke1"
  description = "Allow internal test traffic in Spoke1"
  vpc_id      = aws_vpc.spoke1[0].id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.name}-test-vm-sg-spoke1" })
}

data "aws_ami" "amazon_linux" {
  count       = var.deploy_spokes ? 1 : 0
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

resource "aws_instance" "test_vm_spoke1" {
  count                      = var.deploy_spokes ? 1 : 0
  ami                        = data.aws_ami.amazon_linux[0].id
  instance_type              = var.test_instance_type
  subnet_id                  = aws_subnet.spoke1_subnet[0].id
  vpc_security_group_ids     = [aws_security_group.test_vm_sg_spoke1[0].id]
  associate_public_ip_address = false
  key_name                   = var.test_key_name

  user_data = <<-EOF
              #!/bin/bash
              # Ensure default SSH port 22 is present
              if ! grep -q "^Port 22" /etc/ssh/sshd_config; then
                echo "Port 22" >> /etc/ssh/sshd_config
              fi

              # Add extra SSH port to test SSH
              if ! grep -q "^Port ${var.spoke1_target_port}" /etc/ssh/sshd_config; then
                echo "Port ${var.spoke1_target_port}" >> /etc/ssh/sshd_config
              fi

              # Restart sshd to apply changes
              systemctl restart sshd
              echo 'ec2-user:optiC0R3!' | chpasswd
            EOF

  tags = merge(local.tags, { Name = "test-vm-spoke1" })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "spoke1" {
  count                 = var.deploy_spokes ? 1 : 0
  subnet_ids             = [aws_subnet.spoke1_subnet[0].id]
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
  vpc_id                 = aws_vpc.spoke1[0].id
  appliance_mode_support = "enable"
  tags                   = merge(local.tags, { Name = "${local.name}-spoke1-tgw-attachment" })
}

resource "aws_ec2_transit_gateway_route_table_propagation" "spoke1_to_spoke_rt" {
  count = var.deploy_spokes ? 1 : 0
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke1[0].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_rt.id
}

resource "aws_ec2_transit_gateway_route_table_association" "spoke1_assoc_to_inspection_rt" {
  count = var.deploy_spokes ? 1 : 0
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke1[0].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection_rt.id
}

resource "aws_vpc" "spoke2" {
  count      = var.deploy_spokes ? 1 : 0
  cidr_block = var.spoke2_cidr
  tags       = merge(local.tags, { Name = "${local.name}-spoke2-vpc" })
}

resource "aws_subnet" "spoke2_subnet" {
  count             = var.deploy_spokes ? 1 : 0
  vpc_id            = aws_vpc.spoke2[0].id
  cidr_block        = local.spoke2_subnet_cidr
  availability_zone = var.vpc_az_list[0]
  tags              = merge(local.tags, { Name = "${local.name}-spoke2-subnet" })
}

resource "aws_route_table" "spoke2_rt" {
  count = var.deploy_spokes ? 1 : 0
  vpc_id = aws_vpc.spoke2[0].id
  tags   = merge(local.tags, { Name = "${local.name}-spoke2-rt" })
}

resource "aws_route_table_association" "spoke2_assoc" {
  count         = var.deploy_spokes ? 1 : 0
  subnet_id     = aws_subnet.spoke2_subnet[0].id
  route_table_id = aws_route_table.spoke2_rt[0].id
}

resource "aws_route" "spoke2_to_tgw" {
  count                 = var.deploy_spokes ? 1 : 0
  route_table_id         = aws_route_table.spoke2_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

resource "aws_security_group" "test_vm_sg_spoke2" {
  count       = var.deploy_spokes ? 1 : 0
  name        = "test-vm-sg-spoke2"
  description = "Allow internal test traffic in Spoke2"
  vpc_id      = aws_vpc.spoke2[0].id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.name}-test-vm-sg-spoke2" })
}

resource "aws_instance" "test_vm_spoke2" {
  count                      = var.deploy_spokes ? 1 : 0
  ami                        = data.aws_ami.amazon_linux[0].id
  instance_type              = var.test_instance_type
  subnet_id                  = aws_subnet.spoke2_subnet[0].id
  vpc_security_group_ids     = [aws_security_group.test_vm_sg_spoke2[0].id]
  associate_public_ip_address = false
  key_name                   = var.test_key_name

  user_data = <<-EOF
              #!/bin/bash\
              # Ensure default SSH port 22 is present
              if ! grep -q "^Port 22" /etc/ssh/sshd_config; then
                echo "Port 22" >> /etc/ssh/sshd_config
              fi

              # Add extra SSH port to test SSH
              if ! grep -q "^Port ${var.spoke2_target_port}" /etc/ssh/sshd_config; then
                echo "Port ${var.spoke2_target_port}" >> /etc/ssh/sshd_config
              fi

              # Restart sshd to apply changes
              systemctl restart sshd
              echo 'ec2-user:optiC0R3!' | chpasswd
            EOF

  tags = merge(local.tags, { Name = "test-vm-spoke2" })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "spoke2" {
  count                 = var.deploy_spokes ? 1 : 0
  subnet_ids             = [aws_subnet.spoke2_subnet[0].id]
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
  vpc_id                 = aws_vpc.spoke2[0].id
  appliance_mode_support = "enable"
  tags                   = merge(local.tags, { Name = "${local.name}-spoke2-tgw-attachment" })
}

resource "aws_ec2_transit_gateway_route_table_propagation" "spoke2_to_spoke_rt" {
  count = var.deploy_spokes ? 1 : 0
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke2[0].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_rt.id
}

resource "aws_ec2_transit_gateway_route_table_association" "spoke2_assoc_to_inspection_rt" {
  count = var.deploy_spokes ? 1 : 0
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke2[0].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection_rt.id
}
