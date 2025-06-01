#EC2 permissions for GitHub Private repo pull
resource "aws_iam_role" "ec2_ssm" {
  name = "EC2GitHubAccessRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}
# Role for EC2 to read GitHub PAT from SSM Parameter Store
resource "aws_iam_policy" "ssm_read_pat" {
  name        = "ReadGitHubPAT"
  description = "Allows EC2 to read GitHub PAT from SSM Parameter Store"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ssm:GetParameter",
        Resource = "arn:aws:ssm:us-east-2:${data.aws_caller_identity.current.account_id}:parameter/github_pat"
      }
    ]
  })
}

# Attaching the policy to the role
resource "aws_iam_role_policy_attachment" "ec2_ssm_attach" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = aws_iam_policy.ssm_read_pat.arn
}

data "aws_caller_identity" "current" {} # This makes config account-agnostic, resolving the ARN properly

# Policy for ec2 ssm
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_ssm.name
}
