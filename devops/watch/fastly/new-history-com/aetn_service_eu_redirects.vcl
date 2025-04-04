sub aetn_service_eu_redirects {
  if (req.url ~ "^/(assets|authors|author|bundler|build|css|editorial|emails/unsubscribe|embed|js|news|player|search|static|tag|tags|this-day-in-history|topics|vendor|vip)/?($|.*$)") {
    set req.http.url_whitelisted = "Yes";
  }
}
