sub aetn_services_recv {
  # Redirect apex(http or https) to www(https)
  if (req.http.host == "history.com") {
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  }

  call aetn_baseauth;
  call aetn_eu_redirects;
  call aetn_https_rewrite;

  if (req.url.path ~ "(?i)^/lndex\.php") {
    error 403 "Forbidden";
  }

  if (req.url.path ~ "^/.image/.*$") {
    error 404 "Not Found";
  }

  call aetn_default_backend;
  call aetn_services_rewrites;
  call aetn_services_proxypass;
}
