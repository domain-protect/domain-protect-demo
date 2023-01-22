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

variable "a_record_prefix" {
  description = "prefix to base domain for A record"
}

variable "ec2_public_ip" {
  description = "Public IP address of EC2 instance"
}

variable "tags" {
  description = "Optional tags"
}
