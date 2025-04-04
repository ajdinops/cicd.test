resource "ultradns_record" "cname-assets-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "assets.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "pagerduty_escalation_policy" "prod-watch-assets-escalation-policy" {
  name      = "prod-watch-assets-escalation-policy"
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

resource "pagerduty_service" "prod-watch-assets-service" {
  name              = "prod-watch-assets-service"
  escalation_policy = pagerduty_escalation_policy.prod-watch-assets-escalation-policy.id
  alert_creation    = "create_alerts_and_incidents"
  incident_urgency_rule {
    type    = "constant"
    urgency = "high"
  }
  lifecycle {
    ignore_changes = [
      acknowledgement_timeout, alert_grouping_parameters,
      auto_pause_notifications_parameters, auto_resolve_timeout, response_play,
      incident_urgency_rule, scheduled_actions, support_hours
    ]
  }
}

resource "pagerduty_service_integration" "prod-watch-assets-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.prod-watch-assets-service.id
}

resource "pagerduty_service_integration" "prod-watch-assets-integration-datadog" {
  name    = pagerduty_service.prod-watch-assets-service.name
  service = pagerduty_service.prod-watch-assets-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "prod-watch-assets-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.prod-watch-assets-service.name
  service_key  = pagerduty_service_integration.prod-watch-assets-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "prod-watch-assets-alert" {
  provider          = aws.us-east-1
  name              = "prod-watch-assets-alert"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.prod-watch-assets-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "prod-watch-assets-alert"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-assets"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-assets-iam" {
  provider          = aws.us-east-1
  name              = "prod-watch-assets-iam"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-assets.yaml")
  parameters = {
    Environment = "prod"
  }
  tags = {
    Name                         = "prod-watch-assets-iam"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-assets"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-assets-pipeline" {
  provider          = aws.us-east-1
  name              = "prod-watch-assets-pipeline"
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
    GitHubRepo                  = "aetn.watch.assets"
    GitHubBranch                = "release"
    SourceBucketName            = null
    SourceObjectKey             = null
    ValidationFunction1         = null
    ValidationFunction2         = null
    ValidationFunction3         = null
    CodeBuildServicePolicies    = aws_cloudformation_stack.prod-watch-assets-iam.outputs.PolicyArn
    CodeBuildEnvironment1Key    = "PUSH_TOKEN"
    CodeBuildEnvironment1Type   = "SECRETS_MANAGER"
    CodeBuildEnvironment1Value  = "/codebuild/github/push_token_prod"
    CodeBuildEnvironment2Key    = "AETN_ENV"
    CodeBuildEnvironment2Type   = "PLAINTEXT"
    CodeBuildEnvironment2Value  = "prod"
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
    Name                         = "prod-watch-assets-pipeline"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-assets"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
