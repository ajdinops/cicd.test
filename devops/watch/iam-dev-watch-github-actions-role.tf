resource "aws_cloudformation_stack" "iam-dev-watch-github-actions-role" {
  provider          = aws.us-east-1
  name              = "iam-dev-watch-github-actions-role"
  capabilities      = ["CAPABILITY_NAMED_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-github-actions-role.yaml")
  parameters = {
    Environment = "dev"
  }
  tags = {
    Name                         = "iam-dev-watch-github-actions-role"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:env"                  = "dev"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
