module "lambda" {
  source          = "../lambda"
  name_suffix     = "${var.project}_${var.environment}"
  mongo_url       = module.mongo.mongo_server_url
  s3_bucket_name  = module.files.bucket_name
  db_name         = module.mongo.db_name
  collection_name = var.files_collection_name
}
