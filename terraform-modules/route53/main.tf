data "aws_route53_zone" "website" {
  name         = var.base_domain
  private_zone = false
}

resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "${var.domain_prefix}.${var.base_domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [var.s3_domain_name]
}

resource "aws_route53_record" "a" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "${var.a_record_prefix}.${var.base_domain}"
  type    = "A"
  ttl     = "300"
  records = [var.ec2_public_ip]
}

resource "aws_route53_zone" "subdomain" {
  name = "${var.subdomain_prefix}.${var.base_domain}"
}

resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "${var.subdomain_prefix}.${var.base_domain}"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.subdomain.name_servers
}