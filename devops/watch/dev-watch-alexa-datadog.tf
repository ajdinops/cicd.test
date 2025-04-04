resource "datadog_synthetics_test" "dev-watch-alexa-synthetics-3ibexjt8h" {
  assertion {
    operator = "is"
    target   = "200"
    type     = "statusCode"
  }

  assertion {
    operator = "lessThan"
    target   = "5000"
    type     = "responseTime"
  }

  locations = ["aws:us-east-1"]
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.dev-watch-alexa-service.service_name}"
  name      = "dev-alexa.watch.aetnd.com/flash-briefing/tdih"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "3600"
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "3600"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://dev-alexa.watch.aetnd.com/flash-briefing/tdih"
  }

  status  = "live"
  subtype = "http"
  tags    = ["dev_aetn-watch-alexa_alexa-watch-aetnd-com", "team:watch", "watch", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "dev-watch-alexa-synthetics-xz36yzrbu" {
  assertion {
    operator = "is"
    target   = "200"
    type     = "statusCode"
  }

  assertion {
    operator = "lessThan"
    target   = "5000"
    type     = "responseTime"
  }

  locations = ["aws:us-east-1"]
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.dev-watch-alexa-service.service_name}"
  name      = "origin: dev-alexa.watch.aetnd.com/flash-briefing/tdih"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "3600"
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "3600"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://dev-alexa.watch.aetnd.com/flash-briefing/tdih"
  }

  request_headers = {
    origin-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["dev_aetn-watch-alexa_alexa-watch-aetnd-com", "team:watch", "watch", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "dev-watch-alexa-synthetics-5bi97djz3" {
  assertion {
    operator = "is"
    target   = "200"
    type     = "statusCode"
  }

  assertion {
    operator = "lessThan"
    target   = "5000"
    type     = "responseTime"
  }

  locations = ["aws:us-east-1"]
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.dev-watch-alexa-service.service_name}"
  name      = "dev-devops-alexa.watch.aetnd.com/flash-briefing/tdih"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "3600"
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "3600"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://dev-alexa.watch.aetnd.com/flash-briefing/tdih"
  }

  status  = "live"
  subtype = "http"
  tags    = ["appsvcs", "dev_aetn-devops-code-pipeline_alexa-watch-aetnd-com", "team:watch", "watch", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "dev-watch-alexa-synthetics-95myx6ruv" {
  assertion {
    operator = "is"
    target   = "200"
    type     = "statusCode"
  }

  assertion {
    operator = "lessThan"
    target   = "5000"
    type     = "responseTime"
  }

  locations = ["aws:us-east-1"]
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.dev-watch-alexa-service.service_name}"
  name      = "origin: dev-devops-alexa.watch.aetnd.com/flash-briefing/tdih"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "3600"
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "3600"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://dev-alexa.watch.aetnd.com/flash-briefing/tdih"
  }

  request_headers = {
    origin-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["appsvcs", "dev_aetn-devops-code-pipeline_alexa-watch-aetnd-com", "team:watch", "watch", "terraform"]
  type    = "api"
}
