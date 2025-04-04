sub aetn_service_eu_redirects {

  if (!(req.http.ua_whitelisted) && !(req.http.ip_whitelisted)) {
      call aetn_geoblock_usa;
  }
}