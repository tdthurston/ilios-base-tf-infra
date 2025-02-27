output "oidc_role_arn" {
  description = "ARN of the IAM role for GitHub OIDC authentication"
  value       = aws_iam_role.github_oidc_role.arn
}
