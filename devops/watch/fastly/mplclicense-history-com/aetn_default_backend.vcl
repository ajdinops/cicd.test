sub aetn_default_backend {
  set req.http.Fastly-Orig-Host = req.http.host;
  
  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev-mplclicense-history-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/dev-mplclicense-history-com";
  } elsif (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa-mplclicense-history-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/qa-mplclicense-history-com";
  } else {
    set req.http.host = "prod-mplclicense-history-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/prod-mplclicense-history-com";
  }
  set req.backend = F_TLS_Backend;
}