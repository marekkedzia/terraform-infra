module "main" {
  source                               = "../modules/main"
  environment                          = var.environment
  region                               = var.region
  project                              = var.project
  password_length                      = var.password_length
  budget_limits                        = var.budget_limits
  budgets_subscriber_email_addresses   = var.budgets_subscriber_email_addresses
  mongo_instance_size_name             = var.mongo_instance_size_name
  mongo_cloud_provider_name            = var.mongo_cloud_provider_name
  mongo_cluster_ip_whitelist           = var.mongo_cluster_ip_whitelist
  mongo_aws_region                     = var.mongo_aws_region
  cognito_user_password_minimum_length = var.cognito_user_password_minimum_length
  files_collection_name                = var.files_collection_name
  free_plan_storage_in_kb              = var.free_plan_storage_in_kb
  premium_plan_storage_in_kb           = var.premium_plan_storage_in_kb
}
