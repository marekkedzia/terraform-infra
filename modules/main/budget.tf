module "budget" {
  source   = "../budgets"
  for_each = toset([for limit in var.budget_limits : tostring(limit)])

  limit_amount                       = each.value
  budgets_subscriber_email_addresses = var.budgets_subscriber_email_addresses
}
