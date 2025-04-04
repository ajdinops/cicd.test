# START SNIPPET error_redirect.vcl

if (obj.status == 701) {
  set obj.status = 301;
  set obj.http.Location = obj.response;
  set obj.response = "Moved Permanently";
  return(deliver);
}

# END SNIPPET error_redirect.vcl
