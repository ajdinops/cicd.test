sub aetn_editorials_proxypass {
  if (req.url.path ~ "^/$" ){
    set req.url = "/4uv/index.html";
    error 701 req.url;
  }
  elsif (req.url.path ~ "^/index.html" ){
    set req.url = "/4uv/index.html";
    error 701 req.url;
  }
  else {
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

    set req.backend = editorials_watch_aetnd_com;
    call aetn_sign_s3;
  }
}