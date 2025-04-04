resource "aws_cloudformation_stack" "iam-prod-watch-github-actions-role" {
  provider          = aws.us-east-1
  name              = "iam-prod-watch-github-actions-role"
  capabilities      = ["CAPABILITY_NAMED_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-github-actions-role.yaml")
  parameters = {
    Environment = "prod"
  }
  tags = {
    Name                         = "iam-prod-watch-github-actions-role"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
