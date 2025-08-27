module "dev-inspection" {
  source = "../../modules/inspection"
  vpc_cidr_block = var.vpc_cidr_block
  env            = var.env
  vpc_region = data.aws_region.current.id
}