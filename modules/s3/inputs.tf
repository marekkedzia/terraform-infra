variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}

variable "cors" {
  description = "The CORS configuration for the bucket"
  type        = object({
    allowed_methods = list(string)
    allowed_origins = list(string)
    allowed_headers = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  })
}

variable "lambda_arn" {
  description = "The ARN of the Lambda function to invoke"
  type        = string
}
