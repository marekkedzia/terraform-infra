resource "aws_budgets_budget" "cost" {
  budget_type  = "COST"
  limit_amount = var.limit_amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "FORECASTED"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = var.budgets_subscriber_email_addresses
  }
}
