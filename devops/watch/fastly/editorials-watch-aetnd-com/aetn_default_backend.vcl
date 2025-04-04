sub aetn_default_backend {

  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "prod-editorials-watch-aetnd-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod-editorials-watch-aetnd-com";

  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev-editorials-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/dev-editorials-watch-aetnd-com";
  }

  if (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa-editorials-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/qa-editorials-watch-aetnd-com";
  }

  set req.backend = F_TLS_Backend;
}