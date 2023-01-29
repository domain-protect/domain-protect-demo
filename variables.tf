variable "project" {
  description = "abbreviation for the project, forms first part of resource names"
  default     = "owasp"
}

variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "az1" {
  default = "eu-west-1a"
}

variable "az2" {
  default = "eu-west-1b"
}

variable "base_domain" {
  description = "Base domain, e.g. example.com"
}

variable "domain_prefix_website" {
  description = "Domain prefix used for website"
  default     = "yosemite"
}

variable "subdomain_prefix" {
  description = "subdomain prefix"
  default     = "serengeti"
}

variable "a_record_prefix" {
  description = "A record prefix"
  default     = "fiordland"
}

variable "cloudflare_base_domain" {
  description = "Cloudflare base domain, e.g. example.net"
}

variable "cloudflare_prefix" {
  description = "Cloudflare prefix, e.g. test"
  default     = "corcovado"
}

variable "amazon_linux_major_version" {
  description = "major version of Amazon Linux"
  default     = "5.10-hvm-2.0"
}

variable "instance_type_linux" {
  description = "Instance type"
  default     = "t3.micro"
}

variable "volume_type" {
  description = "ec2 volume type"
  default     = "gp3"
}

variable "vpc_cidr" {
  default = "10.245.0.0/16"
}

variable "subnet_dmz_cidr_az1" {
  default = "10.245.1.0/24"
}

variable "subnet_dmz_cidr_az2" {
  default = "10.245.2.0/24"
}

variable "flow_log_retention_in_days" {
  description = "Days to retain Flow Logs in CloudWatch"
  default     = "30"
}

variable "cloudflare_demo" {
  description = "s3 or eb (Elastic Beanstalk)"
  default     = "eb"
}

variable "tags" {
  type        = map(string)
  description = "Optional Tags"
  default     = {}
}
