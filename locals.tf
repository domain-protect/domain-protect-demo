resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

locals {
  env = lower(terraform.workspace)
}

locals {
  domain_name                     = "${var.domain_prefix_website}.${var.base_domain}"
  bucket_regional_domain_name     = "${local.domain_name}.s3-website-${var.region}.amazonaws.com"
  cloudflare_domain_name          = "${var.cloudflare_prefix}.${var.cloudflare_base_domain}"
  cloudflare_regional_domain_name = "${local.cloudflare_domain_name}.s3-website-${var.region}.amazonaws.com"
  eb_content_bucket_name          = "${var.project}-eb-content-${random_string.random.result}"
  eb_cname_prefix                 = "${var.project}-eb-${random_string.random.result}"
}