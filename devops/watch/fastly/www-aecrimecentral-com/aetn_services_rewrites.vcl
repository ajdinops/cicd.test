sub aetn_services_rewrites {
  if (req.url ~ "^/.well-known") {
    set req.url = "crimecentral" req.url;
  }

  if (std.tolower(req.url.path) == "/wondery") {
    set req.url = regsub(req.url, "(?i)^/wondery", "");
    error 701 req.url;
  }

  if (std.tolower(req.url.path) == "/stitcher") {
    set req.url = regsub(req.url, "(?i)^/stitcher", "");
    error 701 req.url;
  }

  if (std.tolower(req.url.path) == "/iheart") {
    set req.url = regsub(req.url, "(?i)^/iheart", "");
    error 701 req.url;
  }

  if (req.url.path == "/trythreemonths") {
    set req.http.X-Redirect = "https://try.aecrimecentral.com/bundlepromoaecc3/";
    error 703 req.http.X-Redirect;
  }

  if (req.url.path == "/favicon.ico") {
    set req.url = "/assets/images/crimecentral/favicon.ico";
  }

  set req.http.X-Redirect = table.lookup(redirects_301, std.tolower(req.url));

  if (req.http.X-Redirect) {
    error 701 req.http.X-Redirect;
  }
}