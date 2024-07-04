output "role_arn" {
  description = "The ARN of created role"
  value       = aws_iam_role.role.arn
}
