data "pagerduty_user" "default-user" {
  email = "devops@aenetworks.com"
}

data "pagerduty_vendor" "cloudwatch" {
  name = "Amazon CloudWatch"
}

data "pagerduty_vendor" "datadog" {
  name = "Datadog"
}
