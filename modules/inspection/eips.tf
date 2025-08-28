resource "aws_eip" "pafw1_mgmt_eip" {
  count = var.deploy_pan ? 1 : 0
  tags  = merge(local.tags, { Name = "pafw1-mgmt-eip" })
}

resource "aws_eip" "pafw1_untrust_eip" {
  count = var.deploy_pan ? 1 : 0
  tags  = merge(local.tags, { Name = "pafw1-untrust-eip" })
}

resource "aws_eip_association" "pafw1_mgmt_eip_assoc" {
  count               = var.deploy_pan ? 1 : 0
  allocation_id       = aws_eip.pafw1_mgmt_eip[0].id
  network_interface_id = aws_network_interface.pafw1_mgmt_eni[0].id
}

resource "aws_eip_association" "pafw1_untrust_eip_assoc" {
  count               = var.deploy_pan ? 1 : 0
  allocation_id       = aws_eip.pafw1_untrust_eip[0].id
  network_interface_id = aws_network_interface.pafw1_untrust_eni[0].id
}

resource "aws_eip" "pafw2_mgmt_eip" {
  count = var.deploy_pan ? 1 : 0
  tags  = merge(local.tags, { Name = "pafw2-mgmt-eip" })
}

resource "aws_eip" "pafw2_untrust_eip" {
  count = var.deploy_pan ? 1 : 0
  tags  = merge(local.tags, { Name = "pafw2-untrust-eip" })
}

resource "aws_eip_association" "pafw2_mgmt_eip_assoc" {
  count               = var.deploy_pan ? 1 : 0
  allocation_id       = aws_eip.pafw2_mgmt_eip[0].id
  network_interface_id = aws_network_interface.pafw2_mgmt_eni[0].id
}

resource "aws_eip_association" "pafw2_untrust_eip_assoc" {
  count               = var.deploy_pan ? 1 : 0
  allocation_id       = aws_eip.pafw2_untrust_eip[0].id
  network_interface_id = aws_network_interface.pafw2_untrust_eni[0].id
}

