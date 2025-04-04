sub aetn_default_backend {
  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.Origin = req.http.host;
  set req.http.host = "prod-assets-watch-aetnd-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod-assets-watch-aetnd-com";

  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev-assets-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/dev-assets-watch-aetnd-com";
  }

  if (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa-assets-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/qa-assets-watch-aetnd-com";
  }

  set req.backend = assets_watch_aetnd_com;
}