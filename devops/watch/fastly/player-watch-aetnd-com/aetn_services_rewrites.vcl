sub aetn_services_rewrites {

  declare local var.tPid STRING;
  declare local var.siteId STRING;
  declare local var.host STRING;

  if(req.url ~ "^/pservice/embed-player/?.*siteId=([a-z]+)*")
  {
    set var.siteId = re.group.1;

      set var.host = table.lookup(domain_redirects_302, std.tolower(var.siteId));

      if(var.host != "" ){
      if (req.url ~ "^/pservice/embed-player/?.*tPid=([0-9-]+)*") {
          set var.tPid = re.group.1;
          set req.http.X-Redirect = var.host "/embed/" var.tPid;
        error 704 req.http.X-Redirect;
      }else {
        error 404 "Not Found";
      }     
      }else{
        error 404 "Not Found";
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