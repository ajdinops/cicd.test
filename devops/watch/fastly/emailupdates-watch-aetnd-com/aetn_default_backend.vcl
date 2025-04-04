sub aetn_default_backend {

  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.AETN-Bucket = "/prod-emailupdates-watch-aetnd-com";    

  set req.backend = F_TLS_Backend;

  set req.http.Date = now;
  set req.http.host = "prod-emailupdates-watch-aetnd-com.s3.amazonaws.com";
  call aetn_sign_s3;
}