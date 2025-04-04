sub aetn_services_recv {
  set req.url = querystring.sort(req.url);

  set req.http.X-Redirect = "https://www.history.com"; // Redirect historystore.com, www.historystore.com to www.history.com
  error 703 req.http.X-Redirect;
}