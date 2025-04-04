module "qa-historytravel-com-fastly" {
  source = "./modules/fastly/vcl_service"

  service_name = "qa.historytravel.com"

  domains = [
    "qa.historytravel.com",
  ]

  backends = {
    dummy_backend = {
      address = "127.0.0.1"
    }
  }

  snippets = {
    recv_redirect  = { type = "recv", priority = 10, content = file("${path.module}/fastly/historytravel-com/recv_redirect.vcl") }
    error_redirect = { type = "error", priority = 10, content = file("${path.module}/fastly/historytravel-com/error_redirect.vcl") }
  }

  vcls = {
    main = {
      main    = true
      content = file("${path.module}/fastly/historytravel-com/default-min.vcl")
    }
  }

  use_common_snippets         = false
  use_default_vcl             = false
  use_aetn_dictionary         = false
  use_dummy_shielding_backend = false

  tags = {
    "aetnd:service_name" = "qa-web-webcenter"
  }
}
