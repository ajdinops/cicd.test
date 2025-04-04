sub aetn_services_proxypass {
  if (req.url ~ "^/vip" || req.url ~ "^/cic") {
    call aetn_cic_proxypass;
  }
  elsif (req.http.AETN-env ~ "(DEV|QA)" && req.url ~ "^/(embed|player|vendors|_next)/(.*)$") {
    call aetn_player_proxypass;
  }
  # Remove this when new player in prod, it is included in previous elseif
  elsif (req.url ~ "^/player") {
    call aetn_player_proxypass;
  }
  elsif (req.url ~ "^/assets") {
    call aetn_assets_proxypass;
  }
  elsif (req.url ~ "^/apple-touch-icon($|.*$)") {
    set req.url = "/assets/images/fyi" req.url;
    call aetn_assets_proxypass;
  }
}