resource "aws_security_group" "pan_mgmt_sg" {
  count       = var.deploy_pan ? 1 : 0
  name        = "pan-mgmt-sg"
  description = "Allow SSH and HTTPS to PAN management"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

  tags = merge(local.tags, { Name = "${local.prefix}-pan-mgmt-sg" })
}

resource "aws_security_group" "pan_data_sg" {
  count       = var.deploy_pan ? 1 : 0
  name        = "pan-data-sg"
  description = "Allow all traffic for dataplane (adjust for inspection)"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

  tags = merge(local.tags, { Name = "${local.prefix}-pan-data-sg" })
}

resource "aws_security_group" "pan_untrust_sg" {
  count       = var.deploy_pan ? 1 : 0
  name        = "pan-untrust-sg"
  description = "Allow all traffic for dataplane (adjust for inspection)"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

  tags = merge(local.tags, { Name = "${local.prefix}-pan-untrust-sg" })
}

