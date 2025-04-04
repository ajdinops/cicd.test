sub aetn_services_proxypass {
  set req.http.host = "prod.cdn.watch.aetnd.com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod.cdn.watch.aetnd.com";

  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev.cdn.watch.aetnd.com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/dev.cdn.watch.aetnd.com";
  }

  if (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa.cdn.watch.aetnd.com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/qa.cdn.watch.aetnd.com";
  }

  set req.backend = F_TLS_Backend;
  call aetn_sign_s3;
}