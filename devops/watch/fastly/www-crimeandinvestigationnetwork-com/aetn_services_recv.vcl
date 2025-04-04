sub aetn_services_recv {

  call aetn_eu_redirects;

  # redirect apex(http or https) to www(https)
  if (req.http.host == "crimeandinvestigationnetwork.com") {
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  }
  elseif(req.http.host == "ci.tv"){
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  }
  elseif(req.http.host == "ciasia.tv"){
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  }
  else {
    call aetn_https_rewrite;
  }

  call aetn_default_backend;
  call aetn_services_rewrites;
  call aetn_services_proxypass;
}
