variable "domain_prefix" {
  description = "prefix to base domain, e.g. www"
}

variable "base_domain" {
  description = "base domain, e.g. example.com"
}

variable "s3_domain_name" {
  description = "S3 regional domain name"
}

variable "subdomain_prefix" {
  description = "prefix to base domain, e.g. dev"
}

variable "tags" {
  description = "Optional tags"
}
