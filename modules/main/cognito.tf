module "cognito" {
  source          = "../cognito"
  pool_name       = "users-pool-${var.project}-${var.environment}"
  password_length = var.password_length
  pool_client_name = "pool-client-${var.project}-${var.environment}"
}
