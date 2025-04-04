sub aetn_services_rewrites {
  if (req.url ~ "^\/?($|\?.*$)") {
    set req.url = "/index.html";
  }
}