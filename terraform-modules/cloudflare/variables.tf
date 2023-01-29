variable "domain_prefix" {
  description = "prefix to base domain, e.g. www"
}

variable "base_domain" {
  description = "base domain, e.g. example.net"
}

variable "resource_domain_name" {
  description = "Elastic Beanstalk DNS name or S3 regional domain name"
}
