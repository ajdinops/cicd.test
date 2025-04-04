resource "ultradns_rdpool" "a-history-con-com" {
  zone_name   = "history-con.com"
  record_type = "A"
  owner_name  = "history-con.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-history-con-com" {
  zone_name   = "history-con.com"
  record_type = "AAAA"
  owner_name  = "history-con.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-history-con-com" {
  zone_name   = "history-con.com"
  record_type = "CNAME"
  owner_name  = "www.history-con.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-historycon-com" {
  zone_name   = "historycon.com"
  record_type = "A"
  owner_name  = "historycon.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-historycon-com" {
  zone_name   = "historycon.com"
  record_type = "AAAA"
  owner_name  = "historycon.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-historycon-com" {
  zone_name   = "historycon.com"
  record_type = "CNAME"
  owner_name  = "www.historycon.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-historycon-de" {
  zone_name   = "historycon.de"
  record_type = "A"
  owner_name  = "historycon.de."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-historycon-de" {
  zone_name   = "historycon.de"
  record_type = "AAAA"
  owner_name  = "historycon.de."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-historycon-de" {
  zone_name   = "historycon.de"
  record_type = "CNAME"
  owner_name  = "www.historycon.de."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "pagerduty_escalation_policy" "prod-watch-historycon-com-escalation-policy" {
  name      = "prod-watch-historycon-com-escalation-policy"
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

resource "pagerduty_service" "prod-watch-historycon-com-service" {
  name              = "prod-watch-historycon-com-service"
  escalation_policy = pagerduty_escalation_policy.prod-watch-historycon-com-escalation-policy.id
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

resource "pagerduty_service_integration" "prod-watch-historycon-com-integration-cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.prod-watch-historycon-com-service.id
}

resource "pagerduty_service_integration" "prod-watch-historycon-com-integration-datadog" {
  name    = pagerduty_service.prod-watch-historycon-com-service.name
  service = pagerduty_service.prod-watch-historycon-com-service.id
  vendor  = data.pagerduty_vendor.datadog.id
}

resource "datadog_integration_pagerduty_service_object" "prod-watch-historycon-com-service" {
  # when creating the integration object for the first time, the service
  # objects have to be created *after* the integration
  depends_on   = [datadog_integration_pagerduty.pagerduty]
  service_name = pagerduty_service.prod-watch-historycon-com-service.name
  service_key  = pagerduty_service_integration.prod-watch-historycon-com-integration-datadog.integration_key
}

resource "aws_cloudformation_stack" "prod-watch-historycon-com-alert" {
  provider          = aws.us-east-1
  name              = "prod-watch-historycon-com-alert"
  capabilities      = []
  disable_rollback  = false
  notification_arns = []
  template_body     = file("${path.module}/templates/alert.yaml")
  parameters = {
    Email         = null
    HttpEndpoint  = null
    HttpsEndpoint = "https://events.pagerduty.com/integration/${pagerduty_service_integration.prod-watch-historycon-com-integration-cloudwatch.integration_key}/enqueue"
    FallbackEmail = "DevSecOps@aenetworks.com"
  }
  tags = {
    Name                         = "prod-watch-historycon-com-alert"
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

# There are no other resources besides the alert stack. This stack exists
# so that we have a method of sending alerts for the Fastly service.
