resource "aws_cloudformation_stack" "iam-qa-watch-github-actions-role" {
  provider          = aws.us-east-1
  name              = "iam-qa-watch-github-actions-role"
  capabilities      = ["CAPABILITY_NAMED_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-github-actions-role.yaml")
  parameters = {
    Environment = "qa"
  }
  tags = {
    Name                         = "iam-qa-watch-github-actions-role"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
