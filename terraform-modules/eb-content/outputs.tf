output "s3_bucket_arn" {
  value = aws_s3_bucket.content.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.content.id
}

output "s3_object_name" {
  value = aws_s3_object.content.id
}
