# START SNIPPET recv_redirect.vcl

# Redirect to "https://www.aetv.com/home-made"
set req.http.X-Redirect = "https://www.aetv.com/home-made";
error 701 req.http.X-Redirect;

# END SNIPPET recv_redirect.vcl
