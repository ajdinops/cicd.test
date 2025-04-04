resource "datadog_synthetics_test" "prod-watch-editorials-synthetics-wia5mgjmz" {
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
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.prod-watch-editorials-service.service_name}"
  name      = "editorials.watch.aetnd.com/the-obama-years/index.html"

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
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "300"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "http://editorials.watch.aetnd.com/the-obama-years/index.html"
  }

  request_headers = {
    app-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["prod_aetn-watch-editorials_editorials-watch-aetnd-com", "team:editorial", "watch", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "prod-watch-editorials-synthetics-k2pkyizzf" {
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
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.prod-watch-editorials-service.service_name}"
  name      = "origin: editorials.watch.aetnd.com/the-obama-years/index.html"

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
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "300"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "http://editorials.watch.aetnd.com/the-obama-years/index.html"
  }

  request_headers = {
    origin-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["prod_aetn-watch-editorials_editorials-watch-aetnd-com", "team:editorial", "watch", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "prod-watch-editorials-synthetics-wgjd24num" {
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
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.prod-watch-editorials-service.service_name}"
  name      = "livelyplace.com/lively-place/index.html"

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
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "300"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://www.livelyplace.com/lively-place/index.html"
  }

  request_headers = {
    app-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["prod_aetn-watch-editorials_livelyplace-com", "team:editorial", "watch", "terraform"]
  type    = "api"
}

resource "datadog_synthetics_test" "prod-watch-editorials-synthetics-rxr85n882" {
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
  message   = "@pagerduty-${datadog_integration_pagerduty_service_object.prod-watch-editorials-service.service_name}"
  name      = "origin: www.livelyplace.com/lively-place/index.html"

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
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    retry {
      count    = "1"
      interval = "1000"
    }

    tick_every = "300"
  }

  request_definition {
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "https://www.livelyplace.com/lively-place/index.html"
  }

  request_headers = {
    origin-token = "origin-a98162f2ee9f668a17b9e82eae5adb5b4f850a3e"
  }

  status  = "live"
  subtype = "http"
  tags    = ["prod_aetn-watch-editorials_livelyplace-com", "team:editorial", "watch", "terraform"]
  type    = "api"
}