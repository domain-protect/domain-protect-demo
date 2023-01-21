module "vpc" {
  source                     = "./terraform-modules/vpc"
  project                    = var.project
  az1                        = var.az1
  az2                        = var.az2
  vpc_cidr                   = var.vpc_cidr
  subnet_dmz_cidr_az1        = var.subnet_dmz_cidr_az1
  subnet_dmz_cidr_az2        = var.subnet_dmz_cidr_az2
  flow_log_retention_in_days = var.flow_log_retention_in_days
}

module "s3-website" {
  source      = "./terraform-modules/s3-website"
  region      = var.region
  bucket_name = local.domain_name
  tags        = var.tags
}

module "route53" {
  source           = "./terraform-modules/route53"
  base_domain      = var.base_domain
  domain_prefix    = var.domain_prefix_website
  s3_domain_name   = local.bucket_regional_domain_name
  subdomain_prefix = var.subdomain_prefix
  tags             = var.tags
}