module "ilios_oidc" {

  source      = "./modules/oidc"

  github_org  = var.github_org
  github_repo = var.github_repo
  tags        = var.tags
  
}

output "oidc_role_arn" {
  description = "ARN of the IAM role for GitHub OIDC authentication"
  value       = module.ilios_oidc.oidc_role_arn
}