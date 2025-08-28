locals {
  init_cfg_content = var.deploy_pan ? templatefile(
    "${path.module}/templates/init-cfg.tpl",
    {
      plugin_commands = join(",", [
        "set-sess-ress:True",
        "aws-gwlb-inspect:enable",
        format("aws-gwlb-associate-vpce:%s@ethernet1/1.10", aws_vpc_endpoint.gwlb_endpoint_az_0.id),
        format("aws-gwlb-associate-vpce:%s@ethernet1/1.10", aws_vpc_endpoint.gwlb_endpoint_az_1.id),
        "aws-gwlb-overlay-routing:enable"
      ])
      redis_endpoint = try(aws_elasticache_replication_group.pafw_redis[0].primary_endpoint_address, "")
      redis_port     = var.redis_port
      redis_auth     = var.redis_auth_token
    }
  ) : ""
}

resource "aws_s3_bucket" "pan_bootstrap" {
  count  = var.deploy_pan ? 1 : 0
  bucket = var.bootstrap_bucket_name
  tags   = merge(local.tags, { Name = var.bootstrap_bucket_name })
}

resource "aws_s3_bucket_ownership_controls" "pan_bootstrap" {
  count  = var.deploy_pan ? 1 : 0
  bucket = aws_s3_bucket.pan_bootstrap[0].id

  rule { object_ownership = "BucketOwnerEnforced" }
}

resource "aws_s3_bucket_public_access_block" "pan_bootstrap" {
  count  = var.deploy_pan ? 1 : 0
  bucket = aws_s3_bucket.pan_bootstrap[0].id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "bootstrap_folders" {
  count  = var.deploy_pan ? 4 : 0
  bucket = aws_s3_bucket.pan_bootstrap[0].id
  key    = element(["config/", "content/", "software/", "license/"], count.index)
  content = ""
}

resource "aws_s3_object" "init_cfg" {
  count        = var.deploy_pan ? 1 : 0
  bucket       = aws_s3_bucket.pan_bootstrap[0].id
  key          = "config/init-cfg.txt"
  content      = local.init_cfg_content
  content_type = "text/plain"
  depends_on   = [aws_vpc_endpoint.gwlb_endpoint_az_0, aws_vpc_endpoint.gwlb_endpoint_az_1]
}

resource "aws_s3_object" "bootstrap_xml" {
  count        = var.deploy_pan && var.upload_bootstrap_xml && length(var.bootstrap_xml_path) > 0 ? 1 : 0
  bucket       = aws_s3_bucket.pan_bootstrap[0].id
  key          = "config/bootstrap.xml"
  source       = var.bootstrap_xml_path
  content_type = "application/xml"
  etag         = filemd5(var.bootstrap_xml_path)
}
