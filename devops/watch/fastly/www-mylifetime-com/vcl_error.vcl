sub vcl_error {
  if (obj.status == 905) {
    set obj.status = 302;
    set obj.response = "Moved Temporarily";
    set obj.http.Location = "https://eunotice.aenetworks.com";
    synthetic {""};
    return (deliver);
  }
}