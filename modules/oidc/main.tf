data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]

  tags = merge(var.tags, {
    Name = "GitHubActionsOIDCProvider"
  })
}

resource "aws_iam_role" "github_oidc_role" {
  name = "GitHubActionsOIDCRole"
  tags = var.tags

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
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:${var.github_org}/${var.github_repo}:*",
              "repo:${var.github_org}/ilios-golang-api:*"
            ]
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

resource "aws_iam_role_policy_attachment" "github_eks_admin" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_policy" "github_oidc_policy" {
  name        = "GitHubOIDCPolicy"
  description = "Policy for GitHub Actions OIDC authentication"
  tags        = var.tags

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [

          "ec2:Describe*",  
          "eks:*",
          "iam:ListEntitiesForPolicy",
          "iam:GetOpenIDConnectProvider",
          "iam:CreateOpenIDConnectProvider",
          "iam:DeleteOpenIDConnectProvider",
          "iam:GetRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PutRolePolicy",
          "iam:GetRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:PassRole",
          "iam:TagRole",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:GetPolicy",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:GetPolicyVersion",
          "iam:ListPolicyVersions",
          "elasticloadbalancing:*",
          "logs:*"
          
        ]
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::ilios-tf-backend",
          "arn:aws:s3:::ilios-tf-backend/ilios-golang-api/*",
          "arn:aws:s3:::ilios-tf-backend/base-infrastructure/*"
        ]
      }
    ]
  })
}
