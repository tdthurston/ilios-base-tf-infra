module "ilios_oidc" {
  source = "git::https://github.com/tdthurston/ilios-base-tf-infra.git//modules//oidc"

  github_org  = var.github_org
  github_repo = var.github_repo
  aws_region  = var.aws_region

}

output "oidc_role_arn" {
  description = "ARN of the IAM role for GitHub OIDC authentication"
  value       = module.ilios_oidc.oidc_role_arn
}