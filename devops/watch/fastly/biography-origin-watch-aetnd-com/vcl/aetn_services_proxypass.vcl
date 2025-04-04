sub aetn_services_proxypass {

  if (req.url ~ "^/assets") {
    call aetn_assets_proxypass;
  }

  elsif (req.http.AETN-env ~ "(DEV|QA)" && req.url ~ "^/(player|vendors|_next)/(.*)$") {
    call aetn_player_proxypass;
  }

  elsif (req.url ~ "^/vip" || req.url ~ "^/cic") {
    call aetn_cic_proxypass;
  }
}