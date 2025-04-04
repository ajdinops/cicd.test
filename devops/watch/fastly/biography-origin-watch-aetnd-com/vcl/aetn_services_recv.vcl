sub aetn_services_recv {
    if (req.url !~ "^/(aetn-heartbeat.html|player|assets|vendor|build|_next)") {
        error 403 "Forbidden";
    }

    if (fastly.ff.visits_this_service > 0) {
        if (req.http.host == "dev-biography-origin-no-dns.watch.aetnd.com") {
            set req.http.host = "dev.biography.com";
        }
        elsif (req.http.host == "qa-biography-origin-no-dns.watch.aetnd.com") {
            set req.http.host = "qa.biography.com";
        }
        elsif (req.http.host == "biography-origin-no-dns.watch.aetnd.com") {
            set req.http.host = "www.biography.com";
        }
    }

    call aetn_default_backend;
    call aetn_services_proxypass;
    call aetn_services_rewrites;
}
