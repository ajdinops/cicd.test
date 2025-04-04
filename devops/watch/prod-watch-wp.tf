resource "ultradns_record" "cname-wp-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "wp.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "pagerduty_escalation_policy" "prod-watch-wp-escalation-policy" {
  name      = "prod-watch-wp-escalation-policy"
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

resource "pagerduty_service" "prod-watch-wp-service" {
  name              = "prod-watch-wp-service"
  escalation_policy = pagerduty_escalation_policy.prod-watch-wp-escalation-policy.id
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

resource "pagerduty_service_integration" "prod-watch-wp-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.prod-watch-wp-service.id
}

resource "pagerduty_service_integration" "prod-watch-wp-integration-datadog" {
  name    = pagerduty_service.prod-watch-wp-service.name
  service = pagerduty_service.prod-watch-wp-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "prod-watch-wp-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.prod-watch-wp-service.name
  service_key  = pagerduty_service_integration.prod-watch-wp-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "prod-watch-wp-alert" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-alert"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.prod-watch-wp-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "prod-watch-wp-alert"
    "Application ID"             = "WPW"
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

resource "aws_cloudformation_stack" "prod-watch-wp-ecr" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-ecr"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/ecr-private-repository.yaml")
  parameters = {
    ParentKmsKeyStack = null
  }
  tags = {
    Name                         = "prod-watch-wp-ecr"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-wp-sg" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-sg"
  capabilities      = []
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/sg.yaml")
  parameters = {
    ParentVPCStack = "vpc-prod"
  }
  tags = {
    Name                         = "prod-watch-wp-sg"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-wp-iam" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-iam"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/iam-watch-wp.yaml")
  parameters = {
    Environment = "prod"
  }
  tags = {
    Name                         = "prod-watch-wp-iam"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-wp-sqs" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-sqs"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/sqs.yaml")
  parameters = {
    ParentAlertStack                                 = aws_cloudformation_stack.prod-watch-wp-alert.outputs.StackName
    ParentKmsKeyStack                                = null
    QueueName                                        = null
    FifoQueue                                        = "standard"
    MessageRetentionPeriod                           = "345600"
    MaximumMessageSize                               = "262144"
    MaxReceiveCount                                  = "0"
    DelaySeconds                                     = "0"
    ReceiveMessageWaitTime                           = "0"
    VisibilityTimeout                                = "30"
    ContentBasedDeduplication                        = "false"
    AgeOfOldestMessageAlarmThreshold                 = "18000"
    AgeOfOldestMessageAlarmPeriod                    = "60"
    AgeOfOldestMessageAlarmEvaluationPeriods         = "5"
    NumberMessageVisibleAlarmThreshold               = "60000"
    NumberMessageVisibleAlarmPeriod                  = "60"
    NumberMessageVisibleAlarmEvaluationPeriods       = "5"
    DeadLetterMessagesReceivedAlarmThreshold         = "1"
    DeadLetterMessagesReceivedAlarmPeriod            = "60"
    DeadLetterMessagesReceivedAlarmEvaluationPeriods = "5"
  }
  tags = {
    Name                         = "prod-watch-wp-sqs"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-wp-service" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-service"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-service-alb.yaml")
  parameters = {
    ParentVPCStack                                          = "vpc-prod"
    ParentClusterStack                                      = "prod-watch-cluster"
    ParentECRRepositoryStack                                = aws_cloudformation_stack.prod-watch-wp-ecr.outputs.StackName
    ParentAlertStack                                        = aws_cloudformation_stack.prod-watch-wp-alert.outputs.StackName
    ParentZoneStack                                         = null
    ParentClientStack1                                      = aws_cloudformation_stack.prod-watch-wp-sg.outputs.StackName
    ParentClientStack2                                      = "sg-prod"
    ParentClientStack3                                      = null
    LoadBalancerPriority                                    = "35"
    LoadBalancerHostPattern                                 = "wp.watch.aetnd.com"
    LoadBalancerPathPattern                                 = "/*"
    LoadBalancerDeregistrationDelay                         = "60"
    LoadBalancerStickiness                                  = "false"
    TaskPolicies                                            = aws_cloudformation_stack.prod-watch-wp-iam.outputs.PolicyArn
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
    FluentBitConfigFile                                     = null
    EnableDatadogAgent                                      = "false"
    DatadogApiKeySecret                                     = "/datadog/aetnd_ecs_prod"
    DatadogAgentDDSource                                    = "aetn_php"
    SubDomainNameWithDot                                    = null
    DNSRecordWeight                                         = "50"
    Cpu                                                     = "2"
    Memory                                                  = "8"
    EphemeralStorage                                        = "21"
    CpuArchitecture                                         = "X86_64"
    SubnetsReach                                            = "Private"
    AutoScaling                                             = "true"
    DesiredCount                                            = "1"
    MaxCapacity                                             = "32"
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
    Name                         = "prod-watch-wp-service"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-wp-pipeline" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-pipeline"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-ecs-service-pipeline.yaml")
  parameters = {
    ParentClusterStack          = "prod-watch-cluster"
    ParentServiceStack          = aws_cloudformation_stack.prod-watch-wp-service.outputs.StackName
    ParentECRRepositoryStack    = aws_cloudformation_stack.prod-watch-wp-ecr.outputs.StackName
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
    Name                         = "prod-watch-wp-pipeline"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}

resource "aws_cloudformation_stack" "prod-watch-wp-dashboard" {
  provider          = aws.us-east-1
  name              = "prod-watch-wp-dashboard"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/dashboard-fargate-service-alb.yaml")
  parameters = {
    ParentClusterStack = "prod-watch-cluster"
    ParentServiceStack = aws_cloudformation_stack.prod-watch-wp-service.outputs.StackName
    FastlyServiceId    = "5DB20Vvl8D1r9hU1KdTELw"
  }
  tags = {
    Name                         = "prod-watch-wp-dashboard"
    "Application ID"             = "WPW"
    Role                         = "infra"
    "aetnd:application"          = "watch-wp"
    "aetnd:env"                  = "prod"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
  }
}
