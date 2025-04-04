sub aetn_webpay_proxypass {
  set req.backend = F_webpay_commerce_aetnd_com;

  if (req.http.AETN-env ~ "DEV") {
    set req.http.Host = "dev-webpay.aecrimecentral.com";
  } elsif (req.http.AETN-env ~ "QA") {
    set req.http.Host = "qa-webpay.aecrimecentral.com";
  } else {
    set req.http.Host = "webpay.aecrimecentral.com";
  }
}