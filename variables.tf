variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
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

variable "tags" {
  type        = map(string)
  description = "Optional Tags"
  default     = {}
}
