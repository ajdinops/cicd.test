sub aetn_default_backend {
  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "prod-cdn-live-aenetworks-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod-cdn-live-aenetworks-com";
  set req.backend = F_TLS_Backend;
}