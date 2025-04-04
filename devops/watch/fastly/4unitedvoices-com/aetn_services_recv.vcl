sub aetn_services_recv {
  set req.url = querystring.sort(req.url);

  set req.http.X-Redirect = "https://www.4uv.com" req.url; // Redirect 4unitedvoices.com, www.4unitedvoices.com to www.4uv.com
  error 703 req.http.X-Redirect;
}