sub aetn_services_recv {
  set req.url = querystring.sort(req.url);

  set req.http.X-Redirect = "https://www.biography.com" req.url; // Redirect bio.com, www.bio.com to www.biography.com
  error 703 req.http.X-Redirect;
}