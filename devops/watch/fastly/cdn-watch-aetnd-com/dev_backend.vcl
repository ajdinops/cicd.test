backend F_TLS_Backend {
  .between_bytes_timeout = 10s;
  .connect_timeout = 1s;
  .dynamic = true;
  .first_byte_timeout = 15s;
  .host = "dev.cdn.watch.aetnd.com.s3.amazonaws.com";
  .max_connections = 200;
  .port = "443";
  .share_key = "EitJAZbDqfAwbUqLOfBAjcjd";
  .ssl = true;
  .min_tls_version = "1.2";
  .ssl_cert_hostname = "s3.amazonaws.com";
  .ssl_sni_hostname = "s3.amazonaws.com";
  .ssl_check_cert = always;
  .ssl_ciphers = "ECDHE-ECDSA-AES256-GCM-SHA384,ECDHE-RSA-AES256-GCM-SHA384";
  .probe = {
    .expected_response = 200;
    .initial = 1;
    .interval = 60s;
    .request = "GET /aetn-heartbeat.html HTTP/1.1" "Host: dev.cdn.watch.aetnd.com.s3.amazonaws.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
    .threshold = 1;
    .timeout = 5s;
    .window = 2;
    .dummy = true;
  }
}