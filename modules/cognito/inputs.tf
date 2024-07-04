variable "pool_name" {
  description = "The name of the cognito user pool"
  type        = string
}

variable "pool_client_name" {
  description = "The name of the cognito app client"
  type        = string
}

variable "password_length" {
  description = "Minimum length of the password"
  type        = number
}
