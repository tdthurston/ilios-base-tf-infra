module "oidc" {
  source      = "./modules/oidc"
  github_org  = var.github_org
  github_repo = var.github_repo
}

output "oidc_role_arn" {
  description = "ARN of the IAM role for GitHub OIDC authentication"
  value       = module.oidc.oidc_role_arn
}