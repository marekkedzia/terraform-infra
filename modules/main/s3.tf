module "files" {
  source      = "../s3"
  bucket_name = "files-bucket-${var.project}-${var.environment}"
  cors        = {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
  lambda_arn = module.lambda.files_lambda_arn
}

