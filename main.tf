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

module "ec2" {
  source              = "./terraform-modules/ec2"
  project             = var.project
  amazon_linux_ami    = data.aws_ami.amazon_linux.id
  instance_type_linux = var.instance_type_linux
  linux_subnet_id     = module.vpc.az1_dmz_subnet_id
  security_group_id   = module.vpc.security_group_id
  volume_type         = var.volume_type
}

module "s3-website" {
  source      = "./terraform-modules/s3-website"
  region      = var.region
  bucket_name = local.domain_name
  tags        = var.tags
}

module "s3-website-cloudflare" {
  count          = var.cloudflare_demo == "s3" ? 1 : 0
  source         = "./terraform-modules/s3-website"
  region         = var.region
  bucket_name    = local.cloudflare_domain_name
  content_folder = "corcovado"
  tags           = var.tags
}

module "eb-content-cloudflare" {
  count       = var.cloudflare_demo == "eb" ? 1 : 0
  source      = "./terraform-modules/eb-content"
  region      = var.region
  bucket_name = local.eb_content_bucket_name
  tags        = var.tags
}

module "elastic-beanstalk" {
  count               = var.cloudflare_demo == "eb" ? 1 : 0
  source              = "./terraform-modules/eb"
  project             = var.project
  cname_prefix        = local.eb_cname_prefix
  content_bucket_name = module.eb-content-cloudflare[0].s3_bucket_name
  content_object_name = module.eb-content-cloudflare[0].s3_object_name
  security_group_id   = module.vpc.web_security_group_id
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.az1_dmz_subnet_id
  tags                = var.tags
}

module "route53" {
  source           = "./terraform-modules/route53"
  base_domain      = var.base_domain
  domain_prefix    = var.domain_prefix_website
  s3_domain_name   = local.bucket_regional_domain_name
  subdomain_prefix = var.subdomain_prefix
  a_record_prefix  = var.a_record_prefix
  ec2_public_ip    = module.ec2.ec2_public_ip
  tags             = var.tags

  # prevent subdomain takeover during deployment - ensure route53 DNS record created last
  depends_on = [module.s3-website.s3_bucket_arn]
}

module "cloudflare_eb" {
  count                = var.cloudflare_demo == "eb" ? 1 : 0
  source               = "./terraform-modules/cloudflare"
  base_domain          = var.cloudflare_base_domain
  domain_prefix        = var.cloudflare_prefix
  resource_domain_name = "${local.eb_cname_prefix}.${var.region}.elasticbeanstalk.com"

  # prevent subdomain takeover during deployment - ensure Cloudflare DNS record created last
  depends_on = [module.elastic-beanstalk[0].eb_app_version_arn]
}

module "cloudflare_s3" {
  count                = var.cloudflare_demo == "s3" ? 1 : 0
  source               = "./terraform-modules/cloudflare"
  base_domain          = var.cloudflare_base_domain
  domain_prefix        = var.cloudflare_prefix
  resource_domain_name = local.cloudflare_regional_domain_name

  # prevent subdomain takeover during deployment - ensure Cloudflare DNS record created last
  depends_on = [module.s3-website-cloudflare[0].s3_bucket_arn]
}