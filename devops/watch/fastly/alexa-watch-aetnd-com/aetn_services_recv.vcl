sub aetn_services_recv {
  set req.url = querystring.sort(req.url);
  call aetn_https_rewrite;
  call aetn_default_backend;
  return(pass);
}