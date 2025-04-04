sub aetn_services_recv {
  call aetn_eu_redirects;

  # redirect apex(http or https) to www(https)
  if (req.http.host == "mylifetime.com") {
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  }
  else {
    call aetn_https_rewrite;
  }
  if (req.http.host ~ "lifetimelive.com") {
    set req.http.X-Redirect = "https://mylifetime.com";
    if (req.http.AETN-env ~ "DEV") {
      set req.http.X-Redirect = "https://dev.mylifetime.com";
    }
    if (req.http.AETN-env ~ "QA") {
      set req.http.X-Redirect = "https://qa.mylifetime.com";
    }
    error 703 req.http.X-Redirect;
  }
  if (req.url ~ "(?i)^/lndex\.php") {
    error 403 "Forbidden";
  }
  call aetn_default_backend;
  call aetn_services_rewrites;
  call aetn_services_proxypass;
  if (req.url ~ "^/shows/roseannes-nuts([#/\?].*)?$"){
    set req.url = "/shows";
     error 701 req.url;
    }
}