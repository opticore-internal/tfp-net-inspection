module "dev-inspection" {
  source          = "../../modules/inspection"
  vpc_cidr_block  = var.vpc_cidr_block
  env             = var.env
  vpc_region      = data.aws_region.current.id
  amazon_side_asn = 64513
  deploy_pan      = true
  deploy_spokes   = true
  deploy_nlb      = true
}