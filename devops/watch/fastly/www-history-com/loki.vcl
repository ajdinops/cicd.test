sub is_loki_backend BOOL {
    if (
        req.url.path ~ "^/\.(bootscripts|elb-healthcheck|image|logger|productcatalog|rss|amp|applenews|instantarticles|api|preview|components.min.js|app.min.js|config.js|vdz9WS0i/init.js|context-results)($|(\?.*)|(/.*))" ||
        req.url.path ~ "^/(assets-global|components|runtime|site/styles|js/adobe-analytics|site/images|feed/tdih/newsletterfeed)($|(\?.*)|(/.*))" ||
        req.url.path ~ "^/\.well-known/pubvendors\.json" ||
        req.url.path ~ "^/(dday|frederick-douglass-cesar-chavez-monument-restoration|hispanicheritage|juneteenth|knights-templar-stories-knightfall|native-american-heritage|pandemics|pride|ufo-stories|veterans-stories)($|(\?.*)|(/.*))" ||
        req.url.path ~ "^/js/sourcepoint" ||
        req.url.path ~ "^/editorial/.*$" ||
        req.url.path ~ "^/video-of-the-day"
    ) {
        return true;
    }

    return false;
}
