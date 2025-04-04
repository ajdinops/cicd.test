sub aetn_services_rewrites {
  if( req.url.path ~ "/$"){
    if (req.url.qs ~ "^$") {
      set req.url = req.url.path "index.html";
    }
    else {
      set req.url = req.url.path "index.html?" req.url.qs;
    }
  }

  set req.http.X-Redirect = table.lookup(redirects_301, req.url);

  if (req.http.X-Redirect) {
    error 701 req.http.X-Redirect;
  }

  set req.http.X-Redirect = table.lookup(redirects_302, req.url);

  if (req.http.X-Redirect) {
    error 702 req.http.X-Redirect;
  }
}