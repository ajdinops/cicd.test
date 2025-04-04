sub aetn_service_eu_redirects {
  if (!(req.http.ua_whitelisted) && !(req.http.ip_whitelisted)) {
    if (req.url.path ~ "^/(update-password|assets|webpay/_next|favicon.ico)($|.*$)") {
      call aetn_geoblock_usacanada;
    } else {
      call aetn_geoblock_usa;
    }
  }
}