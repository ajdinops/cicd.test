sub aetn_cache_fetch {
    set beresp.ttl = 3800s;  # Default TTL

    # Never cache requests to `.well-known/vercel/*`
    if (req.url.path ~ "^/.well-known/vercel/") {
        return (pass);
    }

    # Increase TTL for static assets
    if ((beresp.status == 200) && req.url ~ "\.(aif|aiff|au|avi|bin|bmp|cab|carb|cct|cdf|class|css|doc|dcr|dtd|eot|exe|flv|gcf|gff|gif|grv|html|hqx|ico|ini|jpeg|jpg|js|json|mov|mp3|nc|otf|pct|png|ppc|pws|svg|swa|swf|ttf|txt|vbs|w32|wav|wbmp|wml|wmlc|wmls|wmlsc|xsd|zip|webp|jxr|hdp|wdp)($|\?)" ) {
        set beresp.ttl = 36h;
    }

    # Reduce cache TTL for DEV and QA environments
    if (req.http.AETN-env ~ "DEV" || req.http.AETN-env ~ "QA") {
        set beresp.grace = 10s;
        set beresp.ttl = 5s;
    }

    # Do not cache 404s
    if (beresp.status == 404) {
        return (pass);
    }
}