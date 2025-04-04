sub aetn_services_proxypass {
  # Convert the URL path to lowercase once and use it throughout
  declare local var.lower_url STRING;
  set var.lower_url = std.tolower(req.url.path);

  # any route containing legacy=true query string will be routed to webcenter backend (legacy)
  if (req.url.qs ~ "legacy=true") {
    set req.backend = F_webcenter_web_aetnd_com;
  } elsif (std.prefixof(req.url.path, "/build/desktop")) {
    set req.backend = F_webcenter_web_aetnd_com;
  } elsif (std.prefixof(req.url.path, "/feeds")) {
    set req.backend = F_webcenter_web_aetnd_com;
  } elsif (std.prefixof(req.url.path, "/chromecast/customreceiver")) {
    set req.backend = F_webcenter_web_aetnd_com;
  } elsif (std.prefixof(req.url.path, "/bundle")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/account")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/purchase")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/redeem/gift")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/redeem/verizon")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/reset-password")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/update-password")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(var.lower_url, "/vizio") || std.prefixof(var.lower_url, "/tv")) {
    # this might be needed for all paths, but for now it is applied for these two cases
    set req.url = var.lower_url;
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/sign-in")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/webpay/_next/")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/svodroadblock/_next/")) {
    set req.backend = F_svodroadblock_web_aetnd_com;
    if (req.http.AETN-env ~ "QA" && req.url.qs != "") {
        set req.url = req.url.path + "?" + req.url.qs;
    }
  } elsif (std.prefixof(req.url.path, "/api/")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/vendors/")) {
    call aetn_webpay_proxypass;
  } elsif (std.prefixof(req.url.path, "/assets")) {
    call aetn_assets_proxypass;
  } elsif (std.prefixof(req.url.path, "/player")) {
    call aetn_player_proxypass;
  } elsif (std.prefixof(req.url.path, "/firetv")) {
    call aetn_webpay_proxypass;
  } else {
    if (req.url.path == "/") {
      if (req.url.qs) {
        set req.url = "/historyvault?" req.url.qs;
      } else {
        set req.url = "/historyvault";
      }
    } else {
      if (req.url.qs) {
        set req.url = "/historyvault" req.url.path "?" req.url.qs;
      } else {
        set req.url = "/historyvault" req.url.path;
      }
    }
  }
}
