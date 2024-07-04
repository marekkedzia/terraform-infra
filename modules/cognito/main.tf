resource "aws_cognito_user_pool" "pool" {
  name = var.pool_name

  mfa_configuration = "OFF"

  password_policy {
    minimum_length                   = var.password_length
    temporary_password_validity_days = 3
  }

  schema {
    name = "userId"
    attribute_data_type = "String"
    mutable = false
    required = false

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name         = var.pool_client_name
  user_pool_id = aws_cognito_user_pool.pool.id
}
