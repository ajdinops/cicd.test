sub aetn_default_backend {

  set req.http.Fastly-Orig-Host = req.http.host;
  set req.http.host = "prod-player-watch-aetnd-com.s3.amazonaws.com";
  set req.http.AETN-Bucket = "/prod-player-watch-aetnd-com";  
  
  if (req.http.AETN-env ~ "DEV") {
    set req.http.host = "dev-player-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/dev-player-watch-aetnd-com";
  }

  if (req.http.AETN-env ~ "QA") {
    set req.http.host = "qa-player-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/qa-player-watch-aetnd-com";
  }

  set req.backend = player_watch_aetnd_com;
}