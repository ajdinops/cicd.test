sub aetn_services_rewrites {
    # Redirect Canadian visitors to the Crime and Investigation Canada website when accessing the schedule page
    if (req.http.AETN-country-code == "CA" && req.url.path ~ "^/schedule") {
        set req.http.X-Redirect = "http://www.crimeandinvestigation.ca/";
        error 704 req.http.X-Redirect;
    }

    # Set the host and redirect to the schedule page based on the environment
    if (req.http.host ~ "(?i)^(.+-)?ci.tv$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".crimeandinvestigationnetwork.com", "www.crimeandinvestigationnetwork.com");
        set req.url = "/schedule";
        error 701 req.url;
    }

    # Redirect to the schedule page if the URL does not match specific patterns
    if ((req.url.path !~ "^/schedule($|\/.*)") && (req.url !~ "^/bundler/.*$") && (req.url !~ "^/googlee80199210dad36c2.html$") && (req.url !~ "^/assets/.*$") && (req.url !~ "^/build/.*$")) {
       set req.url = "/schedule";
       error 701 req.url;
    }
}
