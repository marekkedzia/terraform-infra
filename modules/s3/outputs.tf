output "bucket_arn" {
  description = "The ARN of S3 bucket"
  value       = aws_s3_bucket.files_bucket.arn
}

output "bucket_name" {
  description = "The name of S3 bucket"
  value       = aws_s3_bucket.files_bucket.bucket
}
