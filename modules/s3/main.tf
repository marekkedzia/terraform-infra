resource "aws_s3_bucket" "files_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_cors_configuration" "files_bucket_cors" {
  bucket = aws_s3_bucket.files_bucket.bucket

  cors_rule {
    allowed_methods = var.cors["allowed_methods"]
    allowed_origins = var.cors["allowed_origins"]
    allowed_headers = var.cors["allowed_headers"]
    expose_headers  = var.cors["expose_headers"]
    max_age_seconds = var.cors["max_age_seconds"]
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.files_bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.files_bucket.arn
}
