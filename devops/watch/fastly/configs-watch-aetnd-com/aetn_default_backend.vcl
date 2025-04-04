sub aetn_default_backend {

  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "prod-configs-watch-aetnd-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod-configs-watch-aetnd-com";

  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev-configs-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/dev-configs-watch-aetnd-com";
  }

  if (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa-configs-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/qa-configs-watch-aetnd-com";
  }

  set req.backend = F_TLS_Backend;
}