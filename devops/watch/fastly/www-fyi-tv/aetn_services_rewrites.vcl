sub aetn_services_rewrites {

    if (req.http.AETN-country-code == "CA" && req.url !~ "^/embed/(.*)$" && req.url !~ "^/emails/unsubscribe" && req.url !~ "^/build/" && req.url !~ "^/vendor/" && req.url !~ "^/vip/" && req.url !~ "^/assets/") {
      set req.http.X-Redirect = "http://www.fyitv.ca/";
      error 704 req.http.X-Redirect;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-mafsmash.fyi.tv", "mafsmash.fyi.tv")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv", "www.fyi.tv");
      set req.url = "/shows/married-at-first-sight/interactives/mafs-mash-game";
      error 701 req.url;
    }

    set req.http.X-Redirect = table.lookup(redirects_301, std.tolower(req.url));

    if (req.http.X-Redirect) {
      error 701 req.http.X-Redirect;
    }

    if (req.url ~ "^/thanksgiving") {
      set req.http.X-Redirect = "https://www.pannacooking.com/";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "^/shows/([a-z0-9-_]+)/episodes$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-_]+)/episodes$", "/shows/\1");
      error 701 req.url;
    }

    if (req.url ~ "^/shows/([a-z0-9-_]+)/videos$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-_]+)/videos$", "/shows/\1");
      error 701 req.url;
    }

    if (req.url ~ "^/shows/([a-z0-9-_]+)/(episodes)/(.*)$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-_]+)/(episodes)/(.*)$", "/shows/\1/\2");
      error 701 req.url;
    }

    if (req.url ~ "^/redirect-facebook$") {
      set req.http.X-Redirect = "https://www.facebook.com/FYI";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "^/redirect-twitter$") {
      set req.http.X-Redirect = "https://twitter.com/FYI";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "^/shows/ultimate-staycation") {
      set req.http.X-Redirect = "https://na.pergo.com/pergo-staycation";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/(autherize|active|authorise|authorize|activation|autorize|actvate|authoize)/?($|.*$)") {
      set req.url = "/activate";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/married-at-first-sight($|/.*$)") {
      set req.http.host = "www.mylifetime.com";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/seven-year-switch/?(.*$|[#\?].*$)") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".mylifetime.com", "www.mylifetime.com");
      set req.url = "/shows/seven-year-switch";
      error 701 req.url;
    }

    if (req.url.path == "/favicon.ico") {
      set req.url = "/assets/images/fyi/favicon.ico";
    }

    if (req.url.path ~ "^/(enthusiast\-blocks\-home\-made|homemade|home-made)$") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com","www.aetv.com");
      set req.url = "/home-made";
      error 701 req.url;
    }

    if (req.url ~ "(?i)/blog/([a-z0-9-_]+)/([a-z0-9-_]+)?($|.*$)") {
      set req.url = regsub(req.url, "/blog/([a-z0-9-_]+)/([a-z0-9-_]+)?($|.*$)", "/\1/\2\3");
      error 701 req.url;
    }

    if (req.url ~ "(?i)/blog/([a-z0-9-_]+)?($|.*$)") {
      set req.url = regsub(req.url, "/blog/([a-z0-9-_]+)?($|.*$)", "/\1\2");
      error 701 req.url;
    }

    if (req.url ~ "^/GetOutdoors(\/|$)") {
      set req.url = regsub(req.url, "^/GetOutdoors", "/getoutdoors");
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyiasia.tv","www.fyiasia.tv")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv","www.fyi.tv");
      error 701 req.url;
    }

    if (req.http.AETN-env ~ "(DEV|QA)" && req.url.path ~ "^/embed/(\d+)$") {
      set req.url = regsub(req.url.path, "/embed/(\d+)", "/embed.html") "?" "id=" regsub(req.url.path, "/embed/", "") "&" req.url.qs;
      call aetn_player_proxypass;
    }

    if (req.url.path ~ "(?i)^/specials/revolution-gmc-hummer-ev") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
      error 701 req.url;
    }
}