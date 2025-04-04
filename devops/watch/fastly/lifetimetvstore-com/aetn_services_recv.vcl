sub aetn_services_recv {
  set req.url = querystring.sort(req.url);

  set req.http.X-Redirect = "https://www.mylifetime.com"; // Redirect livetimetv.com, www.livetimetv.com to www.lifetimetv.com
  error 703 req.http.X-Redirect;
}