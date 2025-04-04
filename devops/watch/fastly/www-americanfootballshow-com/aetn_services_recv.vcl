sub aetn_services_recv {

  call aetn_geoblock_usa;
  
  if (req.http.host == "livelyplace.com") {
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  } 
  else {
    call aetn_https_rewrite;
  }
  call aetn_default_backend;
  call aetn_services_proxypass;
  call aetn_services_rewrites;
  call aetn_sign_s3;
}