data "aws_iam_policy_document" "policy_document" {
  dynamic "statement" {
    for_each = var.statements
    content {
      actions = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_role" "role" {
  name = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "${var.service}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "role_policy" {
  name = "${var.role_name}_policy"
  policy = data.aws_iam_policy_document.policy_document.json

  role = aws_iam_role.role.id
}
