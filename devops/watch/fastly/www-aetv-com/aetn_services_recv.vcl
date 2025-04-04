sub aetn_services_recv {

  call aetn_eu_redirects;
  # redirect apex(http or https) to www(https)
  if (req.http.host == "aetv.com") {
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  } else {
    call aetn_https_rewrite;
  }

  if (req.url ~ "(?i)^/lndex\.php") {
    error 403 "Forbidden";
  }

  call aetn_default_backend;
  call aetn_services_rewrites;
  call aetn_services_proxypass;
}