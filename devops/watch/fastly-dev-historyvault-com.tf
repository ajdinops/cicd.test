module "dev-historyvault-com-fastly" {
  source = "./modules/fastly/vcl_service"

  service_name = "dev.historyvault.com"

  domains = [
    "dev.historyvault.com"
  ]
  backends = {
    svodroadblock_web_aetnd_com = {
      address     = "dev-web-ingress.aetnd.io"
      share_key   = "cP5Yj4rLtWLt5NT7L2TGE9PZ"
      healthcheck = "svodroadblock-HC"
    }
    webcenter_web_aetnd_com = {
      address     = "dev-web-webcenter-ingress.aetnd.io"
      share_key   = "t9IAw0ZNTn3yOHemBO4MKtj3"
      healthcheck = "webcenter-HC"
    }
    webpay_commerce_aetnd_com = {
      address     = "dev-commerce-ingress.aetnd.io"
      share_key   = "rqZSrmVlvE30Msbh88RSfJqA"
      healthcheck = "webpay-HC"
    }
  }

  healthchecks = {
    "svodroadblock-HC" = {
      host = "dev-svodroadblock.web.aetnd.com"
    }
    "webcenter-HC" = {
      host = "dev-webcenter.web.aetnd.com"
    }
    "webpay-HC" = {
      host = "dev-webpay.commerce.aetnd.com"
    }
  }

  default_s3_logging = {}

  snippets = {
    aetn_check_shield_recv             = { type = "init", priority = 10 }
    aetn_stale_deliver                 = { type = "init", priority = 15 }
    aetn_stale_fetch                   = { type = "init", priority = 15 }
    aetn_cache_fetch                   = { type = "init", priority = 20 }
    aetn_error                         = { type = "init", priority = 20 }
    aetn_shield                        = { type = "init", priority = 20 }
    aetn_debug_fetch                   = { type = "init", priority = 21 }
    aetn_set_env_recv                  = { type = "init", priority = 25 }
    aetn_stale_error                   = { type = "init", priority = 25 }
    aetn_device_recv                   = { type = "init", priority = 30 }
    aetn_gzip_fetch                    = { type = "init", priority = 30 }
    aetn_geo_recv                      = { type = "init", priority = 35 }
    aetn_deliver                       = { type = "init", priority = 50 }
    aetn_monitoring_check_recv         = { type = "init", priority = 55 }
    aetn_token_auth                    = { type = "init", priority = 60 }
    eu_whitelist_ip                    = { type = "init", priority = 100 }
    aetn_404_s3_fetch                  = { type = "init", priority = 100 }
    aetn_acl                           = { type = "init", priority = 100 }
    aetn_geoblock_europe               = { type = "init", priority = 100 }
    aetn_geoblock_usacanada            = { type = "init", priority = 100 }
    aetn_geoblock_usa                  = { type = "init", priority = 100 }
    aetn_https_rewrite                 = { type = "init", priority = 100 }
    aetn_service_cache_fetch           = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/aetn_service_cache_fetch.vcl") }
    aetn_sign_s3                       = { type = "init", priority = 100 }
    fastly_devicedetect                = { type = "init", priority = 100 }
    logs-kibana                        = { type = "init", priority = 100 }
    eu_whitelist_useragents            = { type = "init", priority = 100 }
    aetn_eu_redirects                  = { type = "init", priority = 100 }
    aetn_service_eu_redirects          = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/aetn_service_eu_redirects.vcl") }
    aetn_corp_ip                       = { type = "init", priority = 100 }
    aetn_assets_proxypass              = { type = "init", priority = 100 }
    aetn_player_proxypass              = { type = "init", priority = 100 }
    backend_dev_assets_watch_aetnd_com = { type = "init", priority = 100 }
    backend_dev_player_watch_aetnd_com = { type = "init", priority = 100 }
    aetn_webpay_proxypass              = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/aetn_webpay_proxypass.vcl") }
    aetn_services_recv                 = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/aetn_services_recv.vcl") }
    aetn_default_backend               = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/aetn_default_backend.vcl") }
    aetn_services_proxypass            = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/aetn_services_proxypass.vcl") }
    aetn_services_rewrites             = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/aetn_services_rewrites.vcl") }
    redirects                          = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/redirects.vcl") }
    vcl_error                          = { type = "init", priority = 100, content = file("${path.module}/fastly/historyvault-com/vcl_error.vcl") }
  }

  vcls = {
    main = {
      main    = true
      content = file("${path.module}/fastly/historyvault-com/default_sigsci.vcl")
    }
  }

  use_common_snippets         = false
  use_default_vcl             = false
  use_aetn_dictionary         = true
  use_dummy_shielding_backend = true

  sigsci_enabled   = true
  sigsci_site_name = "test_dev"
  sigsci_backends  = ["F_svodroadblock_web_aetnd_com", "F_webpay_commerce_aetnd_com", "F_webcenter_web_aetnd_com"]

  tags = {
    "aetnd:service_name" = "dev-web-svodroadblock"
  }
}
