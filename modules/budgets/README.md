# AWS Budgets Budget Resource

## Overview
This Terraform resource manages an AWS Budget for tracking and controlling AWS costs. It allows for setting budget limits and creating notifications based on cost forecasts.

## Resource: aws_budgets_budget

### budget_type
- **Description**: Specifies the type of budget.
- **Value**: 'COST' indicates that the budget is tracking the cost aspect.

### limit_amount
- **Description**: Sets the total amount of money that you want to track as your budget limit.
- **Value**: Uses a variable `var.limit_amount` to dynamically set the budget limit.

### limit_unit
- **Description**: Defines the unit of measure for the budget limit.
- **Value**: 'USD' specifies that the budget limit is denominated in US dollars.

### time_unit
- **Description**: Determines the period for the budget.
- **Value**: 'MONTHLY' means the budget is calculated and applies on a monthly basis.

### notification
- **Description**: Configures notifications based on certain criteria.
    - **comparison_operator**: Defines how the actual or forecasted values are compared against the threshold.
        - **Value**: 'GREATER_THAN' triggers a notification if the cost exceeds the threshold.
    - **notification_type**: Specifies whether the notification is based on actual costs or forecasted costs.
        - **Value**: 'FORECASTED' indicates the notification triggers based on predicted costs.
    - **threshold**: Sets the threshold for triggering notifications.
        - **Value**: 100, meaning the notification is sent when the forecasted cost is 100% above the budget amount.
    - **threshold_type**: Indicates whether the threshold is a fixed value or a percentage.
        - **Value**: 'PERCENTAGE' shows the threshold is set as a percentage.
    - **subscriber_email_addresses**: Lists the email addresses that will receive the notifications.
        - **Value**: Uses `var.budgets_subscriber_email_addresses` to dynamically include subscriber emails.
