sub aetn_services_recv {
  call aetn_https_rewrite;
  call aetn_services_rewrites;
  call aetn_default_backend;
  call aetn_sign_s3;
}