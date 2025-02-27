resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]  # Verify the latest thumbprint from AWS docs
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
            "token.actions.githubusercontent.com:sub" = "repo:your-org/your-repo:*"
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
        Effect   = "Allow"
        Action   = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "s3:ListBucket",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}
