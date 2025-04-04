sub aetn_default_backend {

  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "images-history-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/images-history-com";       
  set req.backend = images_history_com;
}