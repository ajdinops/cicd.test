/* The follwing is to block rogue IP address */
    acl banned_ips {
        "72.24.135.59";
    }

sub aetn_services_recv {
  /* Block Rogue IP address  */
  if ( client.ip ~ banned_ips ) {
       error 405 "Not allowed.";
  }

    call aetn_eu_redirects;
    call aetn_https_rewrite;

  # redirect apex(http or https) to www(https)
  if (req.http.host == "lifetimemovieclub.com") {
    set req.http.X-Redirect = "https://www." req.http.host req.url;
    error 703 req.http.X-Redirect;
  }

  /*  Set custom header to vary cache for subscriber and nonsubscriber  */
  set req.http.AETN-SUB = if(req.http.Cookie ~ "AETN-ssoXSignature", "Yes","No");
  call aetn_default_backend;
  call aetn_services_rewrites;
  call aetn_services_proxypass;
}