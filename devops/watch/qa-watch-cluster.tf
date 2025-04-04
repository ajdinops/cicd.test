resource "pagerduty_escalation_policy" "qa-watch-cluster-escalation-policy" {
  name      = "qa-watch-cluster-escalation-policy"
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

resource "pagerduty_service" "qa-watch-cluster-service" {
  name              = "qa-watch-cluster-service"
  escalation_policy = pagerduty_escalation_policy.qa-watch-cluster-escalation-policy.id
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

resource "pagerduty_service_integration" "qa-watch-cluster-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.qa-watch-cluster-service.id
}

resource "pagerduty_service_integration" "qa-watch-cluster-integration-datadog" {
  name    = pagerduty_service.qa-watch-cluster-service.name
  service = pagerduty_service.qa-watch-cluster-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "qa-watch-cluster-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.qa-watch-cluster-service.name
  service_key  = pagerduty_service_integration.qa-watch-cluster-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "qa-watch-cluster-alert" {
  provider          = aws.us-east-1
  name              = "qa-watch-cluster-alert"
  capabilities      = []
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.qa-watch-cluster-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "qa-watch-cluster-alert"
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

resource "aws_cloudformation_stack" "qa-watch-cluster" {
  provider          = aws.us-east-1
  name              = "qa-watch-cluster"
  capabilities      = ["CAPABILITY_IAM"]
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/fargate-cluster-alb.yaml")
  parameters = {
    ParentVPCStack                                       = "vpc-prod"
    ParentAuthProxyStack                                 = null
    ParentAlertStack                                     = aws_cloudformation_stack.qa-watch-cluster-alert.outputs.StackName
    ParentZoneStack                                      = "zone-aetnd-io"
    ParentS3StackAccessLog                               = "s3-logs-elb"
    ParentClientStack1                                   = "prod-devops-fastlysgmanager-sg"
    ParentClientStack2                                   = null
    ParentClientStack3                                   = null
    ParentWAFStack                                       = null
    LoadBalancerScheme                                   = "internet-facing"
    LoadBalancerCertificateArn                           = "arn:aws:acm:us-east-1:433624884903:certificate/304c74a7-1f09-40af-acc3-f11d8e1e6415"
    LoadBalancerIdleTimeout                              = "60"
    LoadBalancerDeletionProtection                       = "true"
    SubDomainNameWithDot                                 = "qa-watch-ingress."
    DNSRecordWeight                                      = "50"
    HTTPCodeELB5XXTooHighAlarmThreshold                  = "100"
    HTTPCodeELB5XXTooHighAlarmPeriod                     = "60"
    HTTPCodeELB5XXTooHighAlarmEvaluationPeriods          = "5"
    RejectedConnectionCountTooHighAlarmThreshold         = "100"
    RejectedConnectionCountTooHighAlarmPeriod            = "60"
    RejectedConnectionCountTooHighAlarmEvaluationPeriods = "5"
  }
  tags = {
    Name                         = "qa-watch-cluster"
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
