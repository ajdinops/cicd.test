module "prod-homemadenation-com-fastly" {
  source = "./modules/fastly/vcl_service"

  service_name = "homemadenation.com"

  domains = [
    "www.homemadenation.com",
    "homemadenation.com"
  ]

  backends = {
    dummy_backend = {
      address = "127.0.0.1"
    }
  }

  snippets = {
    recv_redirect  = { type = "recv", priority = 10, content = file("${path.module}/fastly/homemadenation-com/recv_redirect.vcl") }
    error_redirect = { type = "error", priority = 10, content = file("${path.module}/fastly/homemadenation-com/error_redirect.vcl") }
  }

  vcls = {
    main = {
      main    = true
      content = file("${path.module}/fastly/homemadenation-com/default-min.vcl")
    }
  }

  use_common_snippets         = false
  use_default_vcl             = false
  use_aetn_dictionary         = false
  use_dummy_shielding_backend = false

  tags = {
    "aetnd:service_name" = "prod-web-webcenter"
  }
}
