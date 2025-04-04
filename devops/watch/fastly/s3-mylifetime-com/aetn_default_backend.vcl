sub aetn_default_backend {
  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "s3.mylifetime.com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/s3.mylifetime.com";

  set req.backend = F_TLS_Backend;
}