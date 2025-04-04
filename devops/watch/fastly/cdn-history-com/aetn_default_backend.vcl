sub aetn_default_backend {

  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "prod-cdn-history-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod-cdn-history-com";    
    
  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev-cdn-history-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/dev-cdn-history-com";
  }

  if (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa-cdn-history-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/qa-cdn-history-com";
  }
    
  set req.backend = F_TLS_Backend;
}