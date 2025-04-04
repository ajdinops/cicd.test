sub is_activate_backend BOOL {
    if (
        req.url.path ~ "^/(a-year-in-history|api|articles|author|authors|collections|this-day-in-history|news|page|search|tag|topics|videos)($|(\?.*)|(/.*))" ||
        req.url.path ~ "^/(.well-known\/acme-challenge|.well-known\/vercel|_next|fonts|vendor\/theoplayer|vendor\/adobe|leaving-ae)($|(\?.*)|(/.*))" ||
        req.url.path ~ "^/pages-sitemap.xml$" ||
        req.url.path ~ "^/sitemap([_-].*)?\.xml$" ||
        req.url.path == "/"
    ) {
        return true;
    }

    return false;
}