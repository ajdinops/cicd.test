resource "ultradns_record" "cname-dev-editorials-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "dev-editorials.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "pagerduty_escalation_policy" "dev-watch-editorials-escalation-policy" {
  name      = "dev-watch-editorials-escalation-policy"
  num_loops = 3
  rule {
    escalation_delay_in_minutes = 15
    target {
      id   = data.pagerduty_user.default-user.id
      type = "user_reference"
    }
  }
  lifecycle {
    ignore_changes = [
      num_loops, rule, teams,
    ]
  }
}

resource "pagerduty_service" "dev-watch-editorials-service" {
  name              = "dev-watch-editorials-service"
  escalation_policy = pagerduty_escalation_policy.dev-watch-editorials-escalation-policy.id
  alert_creation    = "create_alerts_and_incidents"
  incident_urgency_rule {
    type    = "constant"
    urgency = "low"
  }
  lifecycle {
    ignore_changes = [
      acknowledgement_timeout, alert_grouping_parameters,
      auto_pause_notifications_parameters, auto_resolve_timeout, response_play,
      incident_urgency_rule, scheduled_actions, support_hours
    ]
  }
}

resource "pagerduty_service_integration" "dev-watch-editorials-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.dev-watch-editorials-service.id
}

resource "pagerduty_service_integration" "dev-watch-editorials-integration-datadog" {
  name    = pagerduty_service.dev-watch-editorials-service.name
  service = pagerduty_service.dev-watch-editorials-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "dev-watch-editorials-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.dev-watch-editorials-service.name
  service_key  = pagerduty_service_integration.dev-watch-editorials-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "dev-watch-editorials-alert" {
  provider          = aws.us-east-1
  name              = "dev-watch-editorials-alert"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.dev-watch-editorials-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "dev-watch-editorials-alert"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-editorials"
    "aetnd:env"                  = "dev"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "dev-watch-editorials-iam" {
  provider          = aws.us-east-1
  name              = "dev-watch-editorials-iam"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-editorials.yaml")
  parameters = {
    Environment = "dev"
  }
  tags = {
    Name                         = "dev-watch-editorials-iam"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-editorials"
    "aetnd:env"                  = "dev"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "dev-watch-editorials-pipeline" {
  provider          = aws.us-east-1
  name              = "dev-watch-editorials-pipeline"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/devops-code-pipeline.yaml")
  parameters = {
    ParentS3ArtifactBucketStack = "s3-artifacts-codebuild"
    ParentAlertStack            = null
    ParentVPCStack              = null
    ParentClientStack1          = null
    ParentClientStack2          = null
    ParentClientStack3          = null
    SubnetsReach                = "Private"
    CodeCommitRepo              = null
    CodeCommitBranch            = "master"
    GitHubConnectionArn         = "arn:aws:codestar-connections:us-east-1:433624884903:connection/b2a3e0ae-1341-4371-bcf3-31fddfd4e1f7"
    GitHubOwner                 = "aenetworks"
    GitHubRepo                  = "aetn.watch.editorials"
    GitHubBranch                = "develop"
    SourceBucketName            = null
    SourceObjectKey             = null
    ValidationFunction1         = null
    ValidationFunction2         = null
    ValidationFunction3         = null
    CodeBuildServicePolicies    = aws_cloudformation_stack.dev-watch-editorials-iam.outputs.PolicyArn
    CodeBuildEnvironment1Key    = "PUSH_TOKEN"
    CodeBuildEnvironment1Type   = "SECRETS_MANAGER"
    CodeBuildEnvironment1Value  = "/codebuild/github/push_token_dev"
    CodeBuildEnvironment2Key    = "AETN_ENV"
    CodeBuildEnvironment2Type   = "PLAINTEXT"
    CodeBuildEnvironment2Value  = "dev"
    CodeBuildEnvironment3Key    = null
    CodeBuildEnvironment3Type   = "PLAINTEXT"
    CodeBuildEnvironment3Value  = null
    CodeBuildEnvironment        = "LINUX_CONTAINER"
    CodeBuildImageName          = "aws/codebuild/standard:7.0"
    CodeBuildComputeType        = "BUILD_GENERAL1_SMALL"
    CodeBuildBuildSpec          = "buildspec.yaml"
    CodeBuildTimeoutInMinutes   = "60"
    LogsRetentionInDays         = "1"
  }
  tags = {
    Name                         = "dev-watch-editorials-pipeline"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-editorials"
    "aetnd:env"                  = "dev"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
