output "ec2_public_ip" {
  value = aws_instance.linux.public_ip
}
