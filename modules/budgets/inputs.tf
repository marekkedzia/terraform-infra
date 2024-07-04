variable "limit_amount" {
  description = "The amount limit of the budget"
  type        = number
}

variable "budgets_subscriber_email_addresses" {
  description = "Subscribers of budgets notifications"
  type        = list(string)
}
