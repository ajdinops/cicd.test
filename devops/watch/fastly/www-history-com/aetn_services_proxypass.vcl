sub aetn_services_proxypass {
  if (req.url ~ "^/vip" || req.url ~ "^/cic") {
    call aetn_cic_proxypass;
  }
  elsif (req.url ~ "^/assets") {
    call aetn_assets_proxypass;
  }
  elsif (req.url ~ "^/apple-touch-icon($|.*$)") {
    set req.url = "/assets/images/history" req.url;
    call aetn_assets_proxypass;
  }
  elsif (req.url.path ~ "^/(the-obama-years|the-promised-land|george-washington-timeline-life-events|d-day-operation-overlord-timeline-map|area-51-quiz-real-history|george-washington-battle-map-american-revolution)($|.*$)") {
    call aetn_editorials_proxypass;
  }
  elsif (req.url ~ "^/mrss/.*$") {
    set req.url = regsub(req.url, "^/mrss/(.*)", "/\1");
    set req.http.host = "feed.theplatform.com";
    set req.backend = feed_platform_com;
  }
  elsif (req.url ~ "^/s3static/.*$") {
    unset req.http.Authorization;
    set req.http.host = "public-content-aetn.s3.amazonaws.com";
    set req.url = regsub(req.url, "^/s3static/(.*)", "/\1");
    set req.backend = s3_static_history;
  }
  elsif (is_activate_backend()) {
    set req.http.Host = "prod-editorial-history.aenetworks.cloud";

    if (req.http.host ~ "dev.history.com$" || req.http.AETN-env ~ "DEV") {
        set req.http.Host = "dev-editorial-history.aenetworks.cloud";
    }

    if (req.http.host ~ "qa.history.com$" || req.http.AETN-env ~ "QA") {
        set req.http.Host = "qa-editorial-history.aenetworks.cloud";
    }

    set req.backend = F_activate_editorial_aenetworks_cloud;

    # Add the Vercel Protection Bypass Header from the AETN dictionary
    set req.http.X-Vercel-Protection-Bypass = table.lookup(aetn, "vercel-protection-bypass");
  }

  elsif (is_loki_backend()) {
    set req.backend = F_loki_editorial_aetnd_io;
  }
}