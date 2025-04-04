resource "datadog_integration_pagerduty" "pagerduty" {
  subdomain = "aetnd"
  api_token = local.root_outputs["pagerduty_api_token"]
}
