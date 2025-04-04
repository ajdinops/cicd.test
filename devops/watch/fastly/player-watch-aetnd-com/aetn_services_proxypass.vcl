sub aetn_services_proxypass {

    if (req.url ~ "^/assets") {
      call aetn_assets_proxypass;
    }
}