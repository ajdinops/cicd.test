sub aetn_services_proxypass {
}

sub aetn_services_rewrites {
  set req.http.X-Redirect = table.lookup(redirects_301, req.url);

  if (req.http.X-Redirect) {
    error 701 req.http.X-Redirect;
  }

  set req.http.X-Redirect = table.lookup(redirects_302, req.url);

  if (req.http.X-Redirect) {
    error 702 req.http.X-Redirect;
  }
}