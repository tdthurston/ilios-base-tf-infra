data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "github_oidc_role" {
  name = "GitHubActionsOIDCRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_org}/${var.github_repo}:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "github_oidc_policy_attach" {
  name       = "GitHubOIDCPolicyAttachment"
  roles      = [aws_iam_role.github_oidc_role.name]
  policy_arn = aws_iam_policy.github_oidc_policy.arn
}

resource "aws_iam_policy" "github_oidc_policy" {
  name        = "GitHubOIDCPolicy"
  description = "Policy for GitHub Actions OIDC authentication"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          # EKS permissions
          "eks:*",

          # EC2 permissions for networking
          "ec2:*",

          # VPC permissions
          "elasticloadbalancing:*",

          # IAM permissions for role management
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:GetRole",
          "iam:PassRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy"


        ]
        Resource = "*"
      }
    ]
  })
}
