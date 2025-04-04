backend player_watch_aetnd_com {
  .between_bytes_timeout = 10s;
  .connect_timeout = 1s;
  .dynamic = true;
  .first_byte_timeout = 15s;
  .host = "dev-player-watch-aetnd-com.s3.amazonaws.com";
  .max_connections = 200;
  .port = "443";
  .share_key = "uSCCsUCCyrkZPWjhulOnSsqr";
  .ssl = true;
  .min_tls_version = "1.2";
  .ssl_cert_hostname = "dev-player-watch-aetnd-com.s3.amazonaws.com";
  .ssl_sni_hostname = "dev-player-watch-aetnd-com.s3.amazonaws.com";
  .ssl_check_cert = always;
  .ssl_ciphers = "ECDHE-ECDSA-AES256-GCM-SHA384,ECDHE-RSA-AES256-GCM-SHA384";
  .probe = {
    .expected_response = 200;
    .initial = 1;
    .interval = 60s;
    .request = "GET /aetn-heartbeat.html HTTP/1.1" "Host: dev-player-watch-aetnd-comm.s3.amazonaws.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
    .threshold = 1;
    .timeout = 5s;
    .window = 2;
    .dummy = true;
  }
}

backend assets_watch_aetnd_com {
  .between_bytes_timeout = 10s;
  .connect_timeout = 1s;
  .dynamic = true;
  .first_byte_timeout = 15s;
  .host = "dev-assets-watch-aetnd-com.s3.amazonaws.com";
  .max_connections = 200;
  .port = "443";
  .share_key = "aBrNajIcLWKNqFLTimNHzVWY";
  .ssl = true;
  .min_tls_version = "1.2";
  .ssl_cert_hostname = "dev-assets-watch-aetnd-com.s3.amazonaws.com";
  .ssl_sni_hostname = "dev-assets-watch-aetnd-com.s3.amazonaws.com";
  .ssl_check_cert = always;
  .ssl_ciphers = "ECDHE-ECDSA-AES256-GCM-SHA384,ECDHE-RSA-AES256-GCM-SHA384";
  .probe = {
    .expected_response = 200;
    .initial = 1;
    .interval = 60s;
    .request = "GET /aetn-heartbeat.html HTTP/1.1" "Host: dev-assets-watch-aetnd-com.s3.amazonaws.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
    .threshold = 1;
    .timeout = 5s;
    .window = 2;
    .dummy = true;
  }
}

