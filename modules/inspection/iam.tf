resource "aws_iam_role" "pan_s3_read_role" {
  count = var.deploy_pan ? 1 : 0
  name  = "pan-bootstrap-role"
  tags  = merge(local.tags, { Name = "${local.name}-pan-bootstrap-role" })

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "pan_s3_read_policy" {
  count = var.deploy_pan ? 1 : 0
  name  = "pan-bootstrap-read-policy"
  tags  = merge(local.tags, { Name = "${local.name}-pan-bootstrap-read-policy" })

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:GetObject", "s3:ListBucket"],
      Resource = [
        "arn:aws:s3:::${var.bootstrap_bucket_name}",
        "arn:aws:s3:::${var.bootstrap_bucket_name}/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  count      = var.deploy_pan ? 1 : 0
  role       = aws_iam_role.pan_s3_read_role[0].name
  policy_arn = aws_iam_policy.pan_s3_read_policy[0].arn
}

resource "aws_iam_instance_profile" "pan_instance_profile" {
  count = var.deploy_pan ? 1 : 0
  name  = "pan-bootstrap-instance-profile"
  role  = aws_iam_role.pan_s3_read_role[0].name
}
