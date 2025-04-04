sub aetn_services_proxypass {
  if (req.url ~ "^/$|.*") {
    call aetn_editorials_proxypass;
  }
}