sub aetn_services_rewrites {
  set req.http.X-Redirect = table.lookup(redirects_301, req.url);
  if (req.url ~ "^/.well-known") {
    set req.url = "historyvault" req.url;
  }

  if (req.http.AETN-country-code != "US" && req.http.User-Agent ~ "CrazyEgg") {
    set req.http.X-Redirect = "http://www.history.com";
    error 704 req.http.X-Redirect;
  }

  set req.http.X-Redirect = table.lookup(redirects_301, std.tolower(req.url));

  if (req.http.X-Redirect) {
    error 701 req.http.X-Redirect;
  }

  set req.http.X-Redirect = table.lookup(redirects_302, req.url);

  if (req.http.X-Redirect) {
    error 702 req.http.X-Redirect;
  }


  if (req.url ~ "/faq") {
    set req.http.Host = "history.zendesk.com";
    set req.url = "/hc/en-us/categories/202561328";
    error 701 req.url;
  }

  if (req.url.path == "/favicon.ico") {
    set req.url = "/assets/images/historyvault/favicon.ico";
  }

  if (req.url.path == "/featured") {
    set req.http.X-Redirect = "https://watch.historyvault.com/";
    error 704 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/remote") {
    set req.http.X-Redirect = "https://try.historyvault.com/remote/";
    error 703 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/iheart") {
    set req.http.X-Redirect = "https://try.historyvault.com/iheart/";
    error 703 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/food") {
    set req.http.X-Redirect = "https://try.historyvault.com/ftbapodcast/";
    error 703 req.http.X-Redirect;
  }

  if (req.url.path == "/collections") {
    set req.http.X-Redirect = "https://watch.historyvault.com/documentaries";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/america-the-story-of-us") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/america-the-story-of-us-2";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/american-revolution") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/american-revolution";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/american-revolution/american-revolution-battle-of-monmouth") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/american-revolution";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/ancient-rome/constantine") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/ancient-history";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/ancient-rome/spartacus") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/ancient-history";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/battle-360/vengeance-at-midway") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/world-war-ii";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/best-of-vault-year-in-review") {
    set req.http.X-Redirect = "https://watch.historyvault.com/list/editors-picks";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/biography") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/biography";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/biography-the-trump-dynasty") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/biography";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/biography/confucius-words-of-wisdom") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/confucius-words-of-wisdom";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/black-history") {
    set req.http.X-Redirect = "https://watch.historyvault.com/documentaries";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/california-gold-rush/stagecoach-and-the-pony-express") {
    set req.http.X-Redirect = "https://watch.historyvault.com/documentaries";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/clash-of-the-gods") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/clash-of-the-gods";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/clash-of-the-gods/beowulf") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/clash-of-the-gods";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/clash-of-the-gods/hades") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/clash-of-the-gods";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/clash-of-the-gods/odysseus-curse-of-the-sea") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/clash-of-the-gods";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/clash-of-the-gods/zeus") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/clash-of-the-gods";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/dogfights") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/dogfights";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/engineering-an-empire") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/engineering-an-empire";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/explorers") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/world-history";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/greatest-conspiracies-in-history/d-b-cooper-case-closed-par") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/d-b-cooper-case-closed";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/greatest-conspiracies-in-history/secret-societies") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/buried-knights-templar-and-the-holy-grail";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/john-f-kennedy") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/jfk-assassination-the-definitive-guide";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/mankind-the-story-of-all-of-us") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/mankind-the-story-of-all-of-us";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/prohibition/the-saint-valentines-day-massacre") {
    set req.http.X-Redirect = "https://watch.historyvault.com/";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/religion/the-jesus-strand-a-search-for-dna") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/the-jesus-strand-a-search-for-dna";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/rise-and-fall-the-third-reich") {
    set req.http.X-Redirect = "https://watch.historyvault.com/";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/russia/ivan-the-terribles-fortresses") {
    set req.http.X-Redirect = "https://watch.historyvault.com/";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/secrets-of-the-dark-ages/the-dark-ages") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/the-dark-ages";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/special-forces/sniper-inside-the-crosshairs") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/sniper-inside-the-crosshairs";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/thanksgiving") {
    set req.http.X-Redirect = "https://watch.historyvault.com/";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/the-1960s") {
    set req.http.X-Redirect = "https://watch.historyvault.com/";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/the-cold-war") {
    set req.http.X-Redirect = "https://watch.historyvault.com/";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/the-lost-evidence/battle-of-berlin-19") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/the-lost-evidence";
    error 704 req.http.X-Redirect;
  }

   if (req.url.path == "/collections/the-lost-evidence/operation-market-garden-16") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/the-lost-evidence";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/the-men-who-built-america") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/the-men-who-built-america";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/the-universe") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/the-universe";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/unsolved-mysteries-and-legends/roanoke-search-for-the-lost-") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/roanoke-search-for-the-lost-colony";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/us-presidents") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/the-presidents";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/watergate") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/watergate";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/women-of-history") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/biography";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/women-of-history/joan-of-arc-soul-on-fire") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/joan-of-arc-virgin-warrior";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/world-war-1") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/world-war-i";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/world-war-2/pearl-harbor-24-hours-after") {
    set req.http.X-Redirect = "https://watch.historyvault.com/specials/pearl-harbor-24-hours-after";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/collections/wwii-in-hd") {
    set req.http.X-Redirect = "https://watch.historyvault.com/shows/wwii-in-hd";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/playlist-details/wp/12927") {
    set req.http.X-Redirect = "https://watch.historyvault.com/topics/world-war-ii";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path ~ "(?i)^/blindspot$") {
    set req.http.X-Redirect = "https://try.historyvault.com/blindspot";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path ~ "(?i)^/speech$") {
    set req.http.X-Redirect = "https://try.historyvault.com/speech";
    error 704 req.http.X-Redirect;
  }

  if (req.url.path == "/favicon.ico" ) {
    set req.url = "/assets/images/historyvault/favicon.ico";
  }

  if (req.url.path ~ "(?i)^/htalks$") {
    set req.http.X-Redirect = "https://try.historyvault.com/htalks1mo";
    error 704 req.http.X-Redirect;
  }

  if (std.tolower(req.url.path) == "/historymagazine") {
    set req.http.X-Redirect = "https://try.historyvault.com/historymagazine";
    error 704 req.http.X-Redirect;
  }
}