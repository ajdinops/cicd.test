sub aetn_services_rewrites {
  set req.http.X-Redirect = table.lookup(redirects_301, req.url);
  if (req.url ~ "^/.well-known") {
    set req.url = "lmc" req.url;
  }

  if (req.http.AETN-country-code != "US" && req.http.User-Agent ~ "CrazyEgg") {
    set req.http.X-Redirect = "http://www.mylifetime.com";
    error 704 req.http.X-Redirect;
  }

  set req.http.X-Redirect = table.lookup(redirects_301, std.tolower(req.url));

  if (req.http.X-Redirect) {
    error 701 req.http.X-Redirect;
  }


  if (req.url ~ "/faq") {
    set req.http.Host = "mylifetime.zendesk.com";
    set req.url = "/hc/en-us/categories/203070707";
    error 701 req.url;
  }

  if (std.tolower(req.url.path) == "/catherines") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/catherines";
    error 703 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/goodhousekeeping") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/goodhousekeeping";
    error 703 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/womansday") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/womansday";
    error 703 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/countryliving") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/countryliving";
    error 703 req.http.X-Redirect;
  }

  if (req.url.path == "/favicon.ico") {
    set req.url = "/assets/images/lmc/favicon.ico";
  }

  if (std.tolower(req.url.path) == "/saltnpepa") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/saltnpepa";
    error 703 req.http.X-Redirect;
  }
  if (std.tolower(req.url.path) == "/remote") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/remote";
    error 703 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/podcast") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/podcast/";
    error 703 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/iheart") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/iheart/";
    error 703 req.http.X-Redirect;
  }

  if (req.url.path == "/featured") {
    set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-watch.lifetimemovieclub.com", "watch.lifetimemovieclub.com");
    set req.http.X-Redirect = "https://" req.http.host;
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/movies") {
    set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-watch.lifetimemovieclub.com", "watch.lifetimemovieclub.com");
    set req.http.X-Redirect = "https://" req.http.host req.url;
    error 704 req.http.X-Redirect;
  }

  if (req.url.path ~ "(?i)^/GLAAD") {
    set req.http.X-Redirect = "https://try.lifetimemovieclub.com/glaad";
    error 703 req.http.X-Redirect;
  }

  if (req.url.path == "/favicon.ico") {
    set req.url = "/assets/images/lmc/favicon.ico";
  }

}