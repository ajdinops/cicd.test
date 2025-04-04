resource "pagerduty_escalation_policy" "qa-watch-wp-avod-ingest-supercronic-escalation-policy" {
  name      = "qa-watch-wp-avod-ingest-supercronic-escalation-policy"
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

resource "pagerduty_service" "qa-watch-wp-avod-ingest-supercronic-service" {
  name              = "qa-watch-wp-avod-ingest-supercronic-service"
  escalation_policy = pagerduty_escalation_policy.qa-watch-wp-avod-ingest-supercronic-escalation-policy.id
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

resource "pagerduty_service_integration" "qa-watch-wp-avod-ingest-supercronic-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.qa-watch-wp-avod-ingest-supercronic-service.id
}

resource "pagerduty_service_integration" "qa-watch-wp-avod-ingest-supercronic-integration-datadog" {
  name    = pagerduty_service.qa-watch-wp-avod-ingest-supercronic-service.name
  service = pagerduty_service.qa-watch-wp-avod-ingest-supercronic-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "qa-watch-wp-avod-ingest-supercronic-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.qa-watch-wp-avod-ingest-supercronic-service.name
  service_key  = pagerduty_service_integration.qa-watch-wp-avod-ingest-supercronic-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "qa-watch-wp-avod-ingest-supercronic-alert" {
  provider          = aws.us-east-1
  name              = "qa-watch-wp-avod-ingest-supercronic-alert"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.qa-watch-wp-avod-ingest-supercronic-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "qa-watch-wp-avod-ingest-supercronic-alert"
    "Application ID"             = "WPW"
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

resource "aws_cloudformation_stack" "qa-watch-wp-avod-ingest-supercronic-ecr" {
  provider          = aws.us-east-1
  name              = "qa-watch-wp-avod-ingest-supercronic-ecr"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/ecr-private-repository.yaml")
  parameters = {
    ParentKmsKeyStack = null
  }
  tags = {
    Name                         = "qa-watch-wp-avod-ingest-supercronic-ecr"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp-avod-ingest-supercronic"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "qa-watch-wp-avod-ingest-supercronic-service" {
  provider          = aws.us-east-1
  name              = "qa-watch-wp-avod-ingest-supercronic-service"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-service-noalb.yaml")
  parameters = {
    ParentVPCStack                                 = "vpc-prod"
    ParentClusterStack                             = "qa-watch-cluster"
    ParentECRRepositoryStack                       = aws_cloudformation_stack.qa-watch-wp-avod-ingest-supercronic-ecr.outputs.StackName
    ParentAlertStack                               = aws_cloudformation_stack.qa-watch-wp-avod-ingest-supercronic-alert.outputs.StackName
    ParentClientStack1                             = aws_cloudformation_stack.qa-watch-wp-sg.outputs.StackName
    ParentClientStack2                             = "sg-qa"
    ParentClientStack3                             = null
    TaskPolicies                                   = aws_cloudformation_stack.qa-watch-wp-iam.outputs.PolicyArn
    ProxyImage                                     = null
    ProxyCommand                                   = null
    ProxyPort                                      = "8000"
    ProxyEnvironment1Key                           = null
    ProxyEnvironment1Value                         = null
    ProxyEnvironment2Key                           = null
    ProxyEnvironment2Value                         = null
    ProxyEnvironment3Key                           = null
    ProxyEnvironment3Value                         = null
    AppCommand                                     = "docker-avod-ingest-supercronic-entrypoint"
    AppUser                                        = null
    AppPort                                        = "8080"
    AppEnvironment1Key                             = "AETN_ENV"
    AppEnvironment1Value                           = "qa"
    AppEnvironment2Key                             = null
    AppEnvironment2Value                           = null
    AppEnvironment3Key                             = null
    AppEnvironment3Value                           = null
    AppLogDriver                                   = "awsfirelens"
    AppHealthcheckCommand                          = null
    AppHealthcheckInterval                         = "30"
    AppHealthcheckRetries                          = "3"
    AppHealthcheckStartPeriod                      = "30"
    AppHealthcheckTimeout                          = "5"
    SidecarImage                                   = null
    SidecarRepositoryCredentials                   = "/dockerhub/mirror"
    SidecarCommand                                 = null
    SidecarPort                                    = "9000"
    SidecarEnvironment1Key                         = null
    SidecarEnvironment1Value                       = null
    SidecarEnvironment2Key                         = null
    SidecarEnvironment2Value                       = null
    SidecarEnvironment3Key                         = null
    SidecarEnvironment3Value                       = null
    EnableWiz                                      = "true"
    WizApiClientSecret                             = "/wizio-sensor/aetnd_ecs_qa"
    EnableFireLens                                 = "true"
    FluentBitConfigFile                            = null
    EnableDatadogAgent                             = "true"
    DatadogApiKeySecret                            = "/datadog/aetnd_ecs_qa"
    DatadogAgentDDSource                           = "aetn_php"
    Cpu                                            = "1"
    Memory                                         = "8"
    EphemeralStorage                               = "21"
    CpuArchitecture                                = "X86_64"
    SubnetsReach                                   = "Private"
    AutoScaling                                    = "false"
    DesiredCount                                   = "1"
    MaxCapacity                                    = "1"
    MinCapacity                                    = "1"
    LogsRetentionInDays                            = "1"
    ScaleUpPolicyCooldown                          = "120"
    ScaleUpPolicyScalingAdjustment                 = "25"
    ScaleDownPolicyCooldown                        = "300"
    ScaleDownPolicyScalingAdjustment               = "-25"
    AutoScalingCPUHighAlarmThreshold               = "60"
    AutoScalingCPUHighAlarmPeriod                  = "60"
    AutoScalingCPUHighAlarmEvaluationPeriods       = "1"
    AutoScalingCPULowAlarmThreshold                = "30"
    AutoScalingCPULowAlarmPeriod                   = "300"
    AutoScalingCPULowAlarmEvaluationPeriods        = "3"
    CPUUtilizationTooHighAlarmThreshold            = "90"
    CPUUtilizationTooHighAlarmPeriod               = "60"
    CPUUtilizationTooHighAlarmEvaluationPeriods    = "5"
    MemoryUtilizationTooHighAlarmThreshold         = "90"
    MemoryUtilizationTooHighAlarmPeriod            = "60"
    MemoryUtilizationTooHighAlarmEvaluationPeriods = "5"
  }
  tags = {
    Name                         = "qa-watch-wp-avod-ingest-supercronic-service"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "qa-watch-wp-avod-ingest-supercronic-pipeline" {
  provider          = aws.us-east-1
  name              = "qa-watch-wp-avod-ingest-supercronic-pipeline"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-ecs-service-pipeline.yaml")
  parameters = {
    ParentClusterStack          = "qa-watch-cluster"
    ParentServiceStack          = aws_cloudformation_stack.qa-watch-wp-avod-ingest-supercronic-service.outputs.StackName
    ParentECRRepositoryStack    = aws_cloudformation_stack.qa-watch-wp-avod-ingest-supercronic-ecr.outputs.StackName
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
    GitHubRepo                  = "aetn.watch.wp"
    GitHubBranch                = "master"
    SourceBucketName            = null
    SourceObjectKey             = null
    ValidationFunction1         = null
    ValidationFunction2         = null
    ValidationFunction3         = null
    CodeBuildServicePolicies    = null
    CodeBuildEnvironment1Key    = "PUSH_TOKEN"
    CodeBuildEnvironment1Type   = "SECRETS_MANAGER"
    CodeBuildEnvironment1Value  = "/codebuild/github/push_token_qa"
    CodeBuildEnvironment2Key    = "AETN_ENV"
    CodeBuildEnvironment2Type   = "PLAINTEXT"
    CodeBuildEnvironment2Value  = "qa"
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
    Name                         = "qa-watch-wp-avod-ingest-supercronic-pipeline"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}