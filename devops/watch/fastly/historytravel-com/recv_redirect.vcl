# START SNIPPET recv_redirect.vcl

# Redirect to "https://www.history.com"
set req.http.X-Redirect = "https://www.history.com" + req.url;
error 701 req.http.X-Redirect;

# END SNIPPET recv_redirect.vcl
