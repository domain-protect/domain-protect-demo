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