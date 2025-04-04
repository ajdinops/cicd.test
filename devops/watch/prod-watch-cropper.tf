resource "ultradns_record" "cname-cropper-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "cropper.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "pagerduty_escalation_policy" "prod-watch-cropper-escalation-policy" {
  name      = "prod-watch-cropper-escalation-policy"
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

resource "pagerduty_service" "prod-watch-cropper-service" {
  name              = "prod-watch-cropper-service"
  escalation_policy = pagerduty_escalation_policy.prod-watch-cropper-escalation-policy.id
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

resource "pagerduty_service_integration" "prod-watch-cropper-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.prod-watch-cropper-service.id
}

resource "pagerduty_service_integration" "prod-watch-cropper-integration-datadog" {
  name    = pagerduty_service.prod-watch-cropper-service.name
  service = pagerduty_service.prod-watch-cropper-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "prod-watch-cropper-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.prod-watch-cropper-service.name
  service_key  = pagerduty_service_integration.prod-watch-cropper-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "prod-watch-cropper-alert" {
  provider          = aws.us-east-1
  name              = "prod-watch-cropper-alert"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.prod-watch-cropper-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "prod-watch-cropper-alert"
    "Application ID"             = "CRP"
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

resource "aws_cloudformation_stack" "prod-watch-cropper-ecr" {
  provider          = aws.us-east-1
  name              = "prod-watch-cropper-ecr"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/ecr-private-repository.yaml")
  parameters = {
    ParentKmsKeyStack = null
  }
  tags = {
    Name                         = "prod-watch-cropper-ecr"
    "Application ID"             = "CRP"
    Role                         = "infra"
    "aetnd:application"          = "watch-cropper"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-cropper-sg" {
  provider          = aws.us-east-1
  name              = "prod-watch-cropper-sg"
  capabilities      = []
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/sg.yaml")
  parameters = {
    ParentVPCStack = "vpc-prod"
  }
  tags = {
    Name                         = "prod-watch-cropper-sg"
    "Application ID"             = "CRP"
    Role                         = "infra"
    "aetnd:application"          = "watch-cropper"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-cropper-iam" {
  provider          = aws.us-east-1
  name              = "prod-watch-cropper-iam"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-cropper.yaml")
  parameters = {
    Environment = "prod"
  }
  tags = {
    Name                         = "prod-watch-cropper-iam"
    "Application ID"             = "CRP"
    Role                         = "infra"
    "aetnd:application"          = "watch-cropper"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-cropper-service" {
  provider          = aws.us-east-1
  name              = "prod-watch-cropper-service"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-service-alb.yaml")
  parameters = {
    ParentVPCStack                                          = "vpc-prod"
    ParentClusterStack                                      = "prod-watch-cluster"
    ParentECRRepositoryStack                                = aws_cloudformation_stack.prod-watch-cropper-ecr.outputs.StackName
    ParentAlertStack                                        = aws_cloudformation_stack.prod-watch-cropper-alert.outputs.StackName
    ParentZoneStack                                         = null
    ParentClientStack1                                      = aws_cloudformation_stack.prod-watch-cropper-sg.outputs.StackName
    ParentClientStack2                                      = "sg-prod"
    ParentClientStack3                                      = null
    LoadBalancerPriority                                    = "10"
    LoadBalancerHostPattern                                 = "cropper.watch.aetnd.com"
    LoadBalancerPathPattern                                 = "/*"
    LoadBalancerDeregistrationDelay                         = "60"
    LoadBalancerStickiness                                  = "false"
    TaskPolicies                                            = aws_cloudformation_stack.prod-watch-cropper-iam.outputs.PolicyArn
    ProxyImage                                              = null
    ProxyCommand                                            = null
    ProxyPort                                               = "8000"
    ProxyEnvironment1Key                                    = null
    ProxyEnvironment1Value                                  = null
    ProxyEnvironment2Key                                    = null
    ProxyEnvironment2Value                                  = null
    ProxyEnvironment3Key                                    = null
    ProxyEnvironment3Value                                  = null
    AppCommand                                              = null
    AppUser                                                 = null
    AppPort                                                 = "8080"
    AppEnvironment1Key                                      = "AETN_ENV"
    AppEnvironment1Value                                    = "prod"
    AppEnvironment2Key                                      = null
    AppEnvironment2Value                                    = null
    AppEnvironment3Key                                      = null
    AppEnvironment3Value                                    = null
    AppLogDriver                                            = "awsfirelens"
    SidecarImage                                            = null
    SidecarRepositoryCredentials                            = "/dockerhub/mirror"
    SidecarCommand                                          = null
    SidecarPort                                             = "9000"
    SidecarEnvironment1Key                                  = null
    SidecarEnvironment1Value                                = null
    SidecarEnvironment2Key                                  = null
    SidecarEnvironment2Value                                = null
    SidecarEnvironment3Key                                  = null
    SidecarEnvironment3Value                                = null
    EnableWiz                                               = "true"
    WizApiClientSecret                                      = "/wizio-sensor/aetnd_ecs_prod"
    EnableFireLens                                          = "true"
    FluentBitConfigFile                                     = "/fluent-bit/configs/parse-json.conf"
    EnableDatadogAgent                                      = "true"
    DatadogApiKeySecret                                     = "/datadog/aetnd_ecs_prod"
    DatadogAgentDDSource                                    = "aetn_nodejs"
    SubDomainNameWithDot                                    = null
    DNSRecordWeight                                         = "50"
    Cpu                                                     = "4"
    Memory                                                  = "16"
    EphemeralStorage                                        = "21"
    CpuArchitecture                                         = "X86_64"
    SubnetsReach                                            = "Private"
    AutoScaling                                             = "true"
    DesiredCount                                            = "12"
    MaxCapacity                                             = "48"
    MinCapacity                                             = "12"
    HealthCheckPath                                         = "/aetn-heartbeat.html"
    HealthCheckGracePeriod                                  = "60"
    LogsRetentionInDays                                     = "1"
    ScaleUpPolicyCooldown                                   = "120"
    ScaleUpPolicyScalingAdjustment                          = "25"
    ScaleDownPolicyCooldown                                 = "300"
    ScaleDownPolicyScalingAdjustment                        = "-25"
    AutoScalingCPUHighAlarmThreshold                        = "60"
    AutoScalingCPUHighAlarmPeriod                           = "60"
    AutoScalingCPUHighAlarmEvaluationPeriods                = "1"
    AutoScalingCPULowAlarmThreshold                         = "30"
    AutoScalingCPULowAlarmPeriod                            = "300"
    AutoScalingCPULowAlarmEvaluationPeriods                 = "3"
    HTTPCodeTarget5XXTooHighAlarmThreshold                  = "100"
    HTTPCodeTarget5XXTooHighAlarmPeriod                     = "60"
    HTTPCodeTarget5XXTooHighAlarmEvaluationPeriods          = "20"
    TargetConnectionErrorCountTooHighAlarmThreshold         = "100"
    TargetConnectionErrorCountTooHighAlarmPeriod            = "60"
    TargetConnectionErrorCountTooHighAlarmEvaluationPeriods = "5"
    CPUUtilizationTooHighAlarmThreshold                     = "90"
    CPUUtilizationTooHighAlarmPeriod                        = "60"
    CPUUtilizationTooHighAlarmEvaluationPeriods             = "5"
    MemoryUtilizationTooHighAlarmThreshold                  = "90"
    MemoryUtilizationTooHighAlarmPeriod                     = "60"
    MemoryUtilizationTooHighAlarmEvaluationPeriods          = "5"
  }
  tags = {
    Name                         = "prod-watch-cropper-service"
    "Application ID"             = "CRP"
    Role                         = "infra"
    "aetnd:application"          = "watch-cropper"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-cropper-pipeline" {
  provider          = aws.us-east-1
  name              = "prod-watch-cropper-pipeline"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-ecs-service-pipeline.yaml")
  parameters = {
    ParentClusterStack          = "prod-watch-cluster"
    ParentServiceStack          = aws_cloudformation_stack.prod-watch-cropper-service.outputs.StackName
    ParentECRRepositoryStack    = aws_cloudformation_stack.prod-watch-cropper-ecr.outputs.StackName
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
    GitHubRepo                  = "aetn.watch.cropper"
    GitHubBranch                = "release"
    SourceBucketName            = null
    SourceObjectKey             = null
    ValidationFunction1         = null
    ValidationFunction2         = null
    ValidationFunction3         = null
    CodeBuildServicePolicies    = null
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
    Name                         = "prod-watch-cropper-pipeline"
    "Application ID"             = "CRP"
    Role                         = "infra"
    "aetnd:application"          = "watch-cropper"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-cropper-dashboard" {
  provider          = aws.us-east-1
  name              = "prod-watch-cropper-dashboard"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/dashboard-fargate-service-alb.yaml")
  parameters = {
    ParentClusterStack = "prod-watch-cluster"
    ParentServiceStack = aws_cloudformation_stack.prod-watch-cropper-service.outputs.StackName
    FastlyServiceId    = "6QBowwU2PB51lVyCFPrGPV"
  }
  tags = {
    Name                         = "prod-watch-cropper-dashboard"
    "Application ID"             = "CRP"
    Role                         = "infra"
    "aetnd:application"          = "watch-cropper"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
