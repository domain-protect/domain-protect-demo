data "archive_file" "content" {
  type        = "zip"
  source_dir  = "${path.module}/${var.content_folder}"
  output_path = "${path.module}/${var.content_folder}.zip"
}

resource "aws_s3_bucket" "content" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_object" "content" {
  bucket = aws_s3_bucket.content.id
  key    = "${var.content_folder}.zip"
  source = "${path.module}/${var.content_folder}.zip"

  depends_on = [data.archive_file.content]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "website_bucket" {
  bucket = aws_s3_bucket.content.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.content.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}