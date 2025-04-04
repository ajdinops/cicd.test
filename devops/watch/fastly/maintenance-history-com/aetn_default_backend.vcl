sub aetn_default_backend {

  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "prod-maintenance-aetnd-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod-maintenance-aetnd-com";
    
  set req.backend = F_TLS_Backend;
}