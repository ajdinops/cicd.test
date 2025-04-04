sub aetn_services_recv {

  if (req.http.host == "dev.wp.watch.aetnd.com"){
    set req.http.X-Redirect = "https://dev-wp.watch.aetnd.com" req.url;
    error 703 req.http.X-Redirect;
  }
  elsif(req.http.host == "qa.wp.watch.aetnd.com"){
    set req.http.X-Redirect = "https://qa-wp.watch.aetnd.com" req.url;
    error 703 req.http.X-Redirect;
  }
  call aetn_https_rewrite;
	call aetn_default_backend;
	call aetn_services_proxypass;
	call aetn_services_rewrites;
	return(pass);
}