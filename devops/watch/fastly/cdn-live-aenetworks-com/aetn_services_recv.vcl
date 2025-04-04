sub aetn_services_recv {
  call aetn_default_backend;
  call aetn_sign_s3;
  return(pass);
}