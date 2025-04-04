sub aetn_service_eu_redirects {
  if (req.url ~ "^/emails/unsubscribe" || req.url ~ "^/build/" || req.url ~ "^/vendor/" || req.url ~ "^/vip/" || req.url ~ "^/assets/"){
    set req.http.url_whitelisted = "Yes";
  }
}