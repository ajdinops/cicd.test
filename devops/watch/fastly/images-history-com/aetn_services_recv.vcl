sub aetn_services_recv {
  
  if(req.method != "GET" && req.method != "HEAD" && req.method != "OPTIONS") {
    error 403 "Unauthorized";
  }

  call aetn_default_backend;
  call aetn_sign_s3;
}