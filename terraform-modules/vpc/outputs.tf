output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "az1_dmz_subnet_id" {
  value = aws_subnet.subnet_dmz_az1.id
}

output "az2_dmz_subnet_id" {
  value = aws_subnet.subnet_dmz_az1.id
}

output "security_group_id" {
  value = aws_default_security_group.default.id
}

output "web_security_group_id" {
  value = aws_security_group.web_ingress.id
}
