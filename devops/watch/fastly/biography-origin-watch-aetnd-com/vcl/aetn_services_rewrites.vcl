sub aetn_services_rewrites {
  set req.http.X-Redirect = table.lookup(redirects_301, req.url);

  if (req.http.X-Redirect) {
    error 701 req.http.X-Redirect;
  }

  set req.http.X-Redirect = table.lookup(redirects_302, req.url);

  if (req.http.X-Redirect) {
    error 702 req.http.X-Redirect;
  }

  if (req.http.AETN-env ~ "(DEV|QA)" && req.url.path ~ "^/player/vendor/(.*)$") {
    set req.url = regsuball(req.url.path, "/player", "");
    call aetn_player_proxypass;
  }

  if (req.http.AETN-env ~ "(DEV|QA)" && req.url.path ~ "^/player/(\d+)$") {
    set req.url = regsub(req.url.path, "/player/(\d+)", "/editorial.html") "?" "id=" regsub(req.url.path, "/player/", "") "&" req.url.qs;
    call aetn_player_proxypass;
  }
}