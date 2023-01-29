resource "cloudflare_record" "website" {
  zone_id = data.cloudflare_zone.zone.id
  name    = var.domain_prefix
  value   = var.resource_domain_name
  type    = "CNAME"
  proxied = false
}