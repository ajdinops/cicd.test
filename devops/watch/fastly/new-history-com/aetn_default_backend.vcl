sub aetn_default_backend {
  set req.http.host = "new.history.com";

  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev-new.history.com";
  }
  elsif (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa-new.history.com";
  }
  
  set req.backend = F_webcenter_web_aetnd_com;
}

