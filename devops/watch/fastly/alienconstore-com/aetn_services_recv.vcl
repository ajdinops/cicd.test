sub aetn_services_recv {
  set req.url = querystring.sort(req.url);

  set req.http.X-Redirect = "https://www.thealiencon.com"; // Redirect thealienconstore.com, www.thealienconstore.com to www.thealiencon.com
  error 703 req.http.X-Redirect;
}