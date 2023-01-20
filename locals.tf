locals {
  env = lower(terraform.workspace)
}

locals {
  domain_name = "${var.domain_prefix_website}.${var.base_domain}"

  bucket_regional_domain_name = "${local.domain_name}.s3-website-${var.region}.amazonaws.com"
}