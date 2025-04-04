resource "ultradns_record" "cname-qa-alexa-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "qa-alexa.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "pagerduty_escalation_policy" "qa-watch-alexa-escalation-policy" {
  name      = "qa-watch-alexa-escalation-policy"
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

resource "pagerduty_service" "qa-watch-alexa-service" {
  name              = "qa-watch-alexa-service"
  escalation_policy = pagerduty_escalation_policy.qa-watch-alexa-escalation-policy.id
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

resource "pagerduty_service_integration" "qa-watch-alexa-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.qa-watch-alexa-service.id
}

resource "pagerduty_service_integration" "qa-watch-alexa-integration-datadog" {
  name    = pagerduty_service.qa-watch-alexa-service.name
  service = pagerduty_service.qa-watch-alexa-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "qa-watch-alexa-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.qa-watch-alexa-service.name
  service_key  = pagerduty_service_integration.qa-watch-alexa-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "qa-watch-alexa-alert" {
  provider          = aws.us-east-1
  name              = "qa-watch-alexa-alert"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.qa-watch-alexa-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "qa-watch-alexa-alert"
    "Application ID"             = "AXA"
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

resource "aws_cloudformation_stack" "qa-watch-alexa-ecr" {
  provider          = aws.us-east-1
  name              = "qa-watch-alexa-ecr"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/ecr-private-repository.yaml")
  parameters = {
    ParentKmsKeyStack = null
  }
  tags = {
    Name                         = "qa-watch-alexa-ecr"
    "Application ID"             = "AXA"
    Role                         = "infra"
    "aetnd:application"          = "watch-alexa"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "qa-watch-alexa-sg" {
  provider          = aws.us-east-1
  name              = "qa-watch-alexa-sg"
  capabilities      = []
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/sg.yaml")
  parameters = {
    ParentVPCStack = "vpc-prod"
  }
  tags = {
    Name                         = "qa-watch-alexa-sg"
    "Application ID"             = "AXA"
    Role                         = "infra"
    "aetnd:application"          = "watch-alexa"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "qa-watch-alexa-iam" {
  provider          = aws.us-east-1
  name              = "qa-watch-alexa-iam"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-alexa.yaml")
  parameters = {
    Environment = "qa"
  }
  tags = {
    Name                         = "qa-watch-alexa-iam"
    "Application ID"             = "AXA"
    Role                         = "infra"
    "aetnd:application"          = "watch-alexa"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "qa-watch-alexa-cache-1" {
  provider          = aws.us-east-1
  name              = "qa-watch-alexa-cache-1"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/elasticache-memcached.yaml")
  parameters = {
    ParentVPCStack                       = "vpc-prod"
    ParentZoneStack                      = "zone-aetnd-io"
    ParentSSHBastionStack                = null
    ParentAlertStack                     = aws_cloudformation_stack.qa-watch-alexa-alert.outputs.StackName
    ParentClientStack1                   = "sg-qa"
    ParentClientStack2                   = null
    ParentClientStack3                   = null
    EngineVersion                        = "1.6.17"
    CacheNodeType                        = "cache.t4g.micro"
    NumCacheNodes                        = "1"
    SubDomainNameWithDot                 = "qa-watch-alexa-cache."
    DNSRecordWeight                      = "50"
    SubnetsReach                         = "Private"
    CPUUtilizationAlarmThreshold         = "90"
    CPUUtilizationAlarmPeriod            = "60"
    CPUUtilizationAlarmEvaluationPeriods = "5"
    SwapUsageAlarmThreshold              = "268435456"
    SwapUsageAlarmPeriod                 = "60"
    SwapUsageAlarmEvaluationPeriods      = "5"
    EvictionsAlarmThreshold              = "1000"
    EvictionsAlarmPeriod                 = "60"
    EvictionsAlarmEvaluationPeriods      = "5"
    LogsRetentionInDays                  = "1"
    PermissionsBoundary                  = null
  }
  tags = {
    Name                         = "qa-watch-alexa-cache-1"
    "Application ID"             = "AXA"
    Role                         = "infra"
    "aetnd:application"          = "watch-alexa"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "qa-watch-alexa-service" {
  provider          = aws.us-east-1
  name              = "qa-watch-alexa-service"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-service-alb.yaml")
  parameters = {
    ParentVPCStack                                          = "vpc-prod"
    ParentClusterStack                                      = "qa-watch-cluster"
    ParentECRRepositoryStack                                = aws_cloudformation_stack.qa-watch-alexa-ecr.outputs.StackName
    ParentAlertStack                                        = aws_cloudformation_stack.qa-watch-alexa-alert.outputs.StackName
    ParentZoneStack                                         = null
    ParentClientStack1                                      = aws_cloudformation_stack.qa-watch-alexa-sg.outputs.StackName
    ParentClientStack2                                      = "sg-qa"
    ParentClientStack3                                      = null
    LoadBalancerPriority                                    = "20"
    LoadBalancerHostPattern                                 = "qa-alexa.watch.aetnd.com"
    LoadBalancerPathPattern                                 = "/*"
    LoadBalancerDeregistrationDelay                         = "60"
    LoadBalancerStickiness                                  = "false"
    TaskPolicies                                            = aws_cloudformation_stack.qa-watch-alexa-iam.outputs.PolicyArn
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
    AppPort                                                 = "4000"
    AppEnvironment1Key                                      = "AETN_ENV"
    AppEnvironment1Value                                    = "qa"
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
    WizApiClientSecret                                      = "/wizio-sensor/aetnd_ecs_qa"
    EnableFireLens                                          = "true"
    FluentBitConfigFile                                     = "/fluent-bit/configs/parse-json.conf"
    EnableDatadogAgent                                      = "true"
    DatadogApiKeySecret                                     = "/datadog/aetnd_ecs_qa"
    DatadogAgentDDSource                                    = "aetn_nodejs"
    SubDomainNameWithDot                                    = null
    DNSRecordWeight                                         = "50"
    Cpu                                                     = "1"
    Memory                                                  = "8"
    EphemeralStorage                                        = "21"
    CpuArchitecture                                         = "X86_64"
    SubnetsReach                                            = "Private"
    AutoScaling                                             = "false"
    DesiredCount                                            = "1"
    MaxCapacity                                             = "1"
    MinCapacity                                             = "1"
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
    HTTPCodeTarget5XXTooHighAlarmEvaluationPeriods          = "5"
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
    Name                         = "qa-watch-alexa-service"
    "Application ID"             = "AXA"
    Role                         = "infra"
    "aetnd:application"          = "watch-alexa"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "qa-watch-alexa-pipeline" {
  provider          = aws.us-east-1
  name              = "qa-watch-alexa-pipeline"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-ecs-service-pipeline.yaml")
  parameters = {
    ParentClusterStack          = "qa-watch-cluster"
    ParentServiceStack          = aws_cloudformation_stack.qa-watch-alexa-service.outputs.StackName
    ParentECRRepositoryStack    = aws_cloudformation_stack.qa-watch-alexa-ecr.outputs.StackName
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
    GitHubRepo                  = "aetn.watch.alexa"
    GitHubBranch                = "qa"
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
    Name                         = "qa-watch-alexa-pipeline"
    "Application ID"             = "AXA"
    Role                         = "infra"
    "aetnd:application"          = "watch-alexa"
    "aetnd:env"                  = "qa"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
