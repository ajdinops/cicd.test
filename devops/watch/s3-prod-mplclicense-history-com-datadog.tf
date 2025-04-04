resource "datadog_synthetics_test" "s3-prod-mplclicense-history-com-synthetics-556ivm7rb" {
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

  locations = ["aws:us-east-1", "azure:eastus"]
  message   = "@pagerduty-prod-web-webcenter-service"
  name      = "mplclicense.history.com/"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "300"
    min_location_failed             = "2"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "60"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://mplclicense.history.com/"
  }

  request_headers = {
    app-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["mktg", "prod_aetn-history-mplclicense_mplclicense-history-com", "team:web", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "s3-prod-mplclicense-history-com-synthetics-dxzpuzbjp" {
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

  locations = ["aws:us-east-1", "azure:eastus"]
  message   = "@pagerduty-prod-web-webcenter-service"
  name      = "mplclicense.history.com/mplclicense"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "300"
    min_location_failed             = "2"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "60"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://mplclicense.history.com/mplclicense/index.html"
  }

  request_headers = {
    app-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["mktg", "prod_aetn-history-mplclicense_mplclicense-history-com", "team:web", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "s3-prod-mplclicense-history-com-synthetics-njmu4kjmc" {
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

  locations = ["aws:us-east-1", "azure:eastus"]
  message   = "@pagerduty-prod-web-webcenter-service"
  name      = "origin: mplclicense.history.com/"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "300"
    min_location_failed             = "2"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "60"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://mplclicense.history.com/"
  }

  request_headers = {
    origin-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["mktg", "prod_aetn-history-mplclicense_mplclicense-history-com", "team:web", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "s3-prod-mplclicense-history-com-synthetics-w4n4vneq8" {
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

  locations = ["aws:us-east-1", "azure:eastus"]
  message   = "@pagerduty-prod-web-webcenter-service"
  name      = "origin: mplclicense.history.com/mplclicense/index.html"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "300"
    min_location_failed             = "2"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "60"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://mplclicense.history.com/mplclicense/index.html"
  }

  request_headers = {
    origin-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["mktg", "prod_aetn-history-mplclicense_mplclicense-history-com", "team:web", "terraform"]
  type    = "api"
}
