sub aetn_default_backend {
  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "pdk-watch-aetnd-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/pdk-watch-aetnd-com";
  set req.backend = F_TLS_Backend;
  call aetn_sign_s3;
}