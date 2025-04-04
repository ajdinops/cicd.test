resource "ultradns_record" "cname-player-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "player.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-player-aetndigital-com" {
  zone_name   = "aetndigital.com"
  record_type = "CNAME"
  owner_name  = "player.aetndigital.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-player-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "player.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-player-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "player.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-player-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "player.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-player-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "player.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "pagerduty_escalation_policy" "prod-watch-player-escalation-policy" {
  name      = "prod-watch-player-escalation-policy"
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

resource "pagerduty_service" "prod-watch-player-service" {
  name              = "prod-watch-player-service"
  escalation_policy = pagerduty_escalation_policy.prod-watch-player-escalation-policy.id
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

resource "pagerduty_service_integration" "prod-watch-player-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.prod-watch-player-service.id
}

resource "pagerduty_service_integration" "prod-watch-player-integration-datadog" {
  name    = pagerduty_service.prod-watch-player-service.name
  service = pagerduty_service.prod-watch-player-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "prod-watch-player-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.prod-watch-player-service.name
  service_key  = pagerduty_service_integration.prod-watch-player-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "prod-watch-player-alert" {
  provider          = aws.us-east-1
  name              = "prod-watch-player-alert"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.prod-watch-player-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "prod-watch-player-alert"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-player"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-player-iam" {
  provider          = aws.us-east-1
  name              = "prod-watch-player-iam"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-player.yaml")
  parameters = {
    Environment = "prod"
  }
  tags = {
    Name                         = "prod-watch-player-iam"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-player"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-player-pipeline" {
  provider          = aws.us-east-1
  name              = "prod-watch-player-pipeline"
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
    GitHubRepo                  = "aetn.watch.player"
    GitHubBranch                = "release"
    SourceBucketName            = null
    SourceObjectKey             = null
    ValidationFunction1         = null
    ValidationFunction2         = null
    ValidationFunction3         = null
    CodeBuildServicePolicies    = aws_cloudformation_stack.prod-watch-player-iam.outputs.PolicyArn
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
    Name                         = "prod-watch-player-pipeline"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetnd:application"          = "watch-player"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
