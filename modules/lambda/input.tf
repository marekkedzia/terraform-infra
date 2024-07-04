variable "lambda_runtime" {
  description = "The runtime to use for the lambda function"
  default     = "nodejs18.x"
}
variable "name_suffix" {
  description = "The suffix to append to the lambda function name"
  type        = string
}

variable "mongo_url" {
  description = "The URL of the MongoDB instance"
  type        = string
}

variable "s3_bucket_name" {
  description = "The S3 bucket where files are stored"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "collection_name" {
  description = "The name of the collection"
  type        = string
}
