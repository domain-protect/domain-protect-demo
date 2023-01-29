variable "region" {
  description = "AWS region for S3 bucket"
}

variable "bucket_name" {
  description = "Name of S3 bucket"
}

variable "tags" {
  description = "Optional tags"
}

variable "content_folder" {
  description = "Folder name for website content"
  default     = "corcovado"
}
