sub aetn_services_rewrites {
    if (req.url !~ "^/embed/(.*)$" && req.url !~ "^/emails/unsubscribe" && req.url !~ "^/build/" && req.url !~ "^/vendor/" && req.url !~ "^/vip/" && req.url !~ "^/assets/") {
      set req.http.X-Redirect = table.lookup(country_redirects_302, std.tolower(req.http.AETN-country-code));
        if (req.http.X-Redirect) {
          error 704 req.http.X-Redirect;
        }
    }

    if (req.url.path ~ "(?i)^/vcandrewsdawnsweeps" && req.url.path != "/vcandrewsdawnsweeps") {
        set req.url = "/vcandrewsdawnsweeps";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/vcandrewsdawnrules" && req.url.path != "/vcandrewsdawnrules") {
        set req.url = "/vcandrewsdawnrules";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/summerromancesweepstakes$" && req.url.path != "/summerromancesweepstakes") {
        set req.url = "/summerromancesweepstakes";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/summerromancesweepstakesrules$" && req.url.path != "/summerromancesweepstakesrules") {
        set req.url = "/summerromancesweepstakesrules";
        error 701 req.url;
    }

    if (req.url.path == "/movies/a-recipe-for-seduction") {
        set req.http.X-Redirect = "https://www.mylifetime.com/";
        error 703 req.http.X-Redirect;
    }

    if (req.http.host ~ "(?i)^(.+-)?captionsplash.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?downloads.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        set req.url = "/games";
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?fanfave.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?fashiongames.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        set req.url = "/games";
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?maids.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?moms.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?moviemashup.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        set req.url = "/movies";
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?shop.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        set req.url = "/lifetime-movie-club";
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?ej.dance.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".mylifetime.com", "www.mylifetime.com");
        error 701 req.url;
    }

    if (req.http.host ~ "(?i)^(.+-)?shop.mylifetime.com$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + "-shop.history.com", "shop.history.com");
        set req.url = "/?v=lifetime";
        error 701 req.url;
    }

    set req.http.X-Redirect = table.lookup(redirects_301, std.tolower(req.url));
    if (req.http.X-Redirect && req.http.X-Redirect != req.url) {
      error 701 req.http.X-Redirect;
    }

    if (req.url ~ "/shows/hoarders($|/$)") {
      set req.http.host = "www.aetv.com";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/([a-z0-9-]+)/video(/?$|/full-episodes/?$)") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-]+)/video(/?$|/full-episodes/?$)", "/shows/\1");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+)/(.*)/?$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+)/(.*)/?$", "/shows/\1/videos/\4");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+).*") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+).*", "/shows/\1/season-\2/episode-\3");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/([a-z0-9-]+)/video/([a-z0-9-]+)/season-([0-9-]+)/episode-([0-9-]+)/(.*)$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-]+)/video/([a-z0-9-]+)/season-([0-9-]+)/episode-([0-9-]+)/(.*)$", "/shows/\1/videos/\5");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/([a-z0-9-]+)/video/(.*)$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-]+)/video/(.*)$", "/shows/\1/videos/\2");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/([a-z0-9-]+)/videos$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-]+)/videos$", "/shows/\1");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/([a-z0-9-]+)/episodes/?($|.*$)") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-]+)/episodes/?($|.*$)", "/shows/\1");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/([a-z0-9-]+)/video/([a-z0-9-\?]+)") {
      set req.url = regsub(req.url, "/shows/([a-z0-9-]+)/video/([a-z0-9-\?]+)", "/shows/\1/videos/\2");
      error 701 req.url;
    }
    elsif (req.url ~ "^/shows/(project-runway|dance-moms)/photos/?($|.*$)") {
      set req.url = regsub(req.url, "/shows/(project-runway|dance-moms)/photos/?($|.*$)", "/shows/\1/pictures");
      error 701 req.url;
    }
    elsif (req.url ~ "^/movies/([a-z0-9-]+)/video(/?$|/full-episodes/?$)") {
      set req.url = regsub(req.url, "^/movies/([a-z0-9-]+)/video(/?$|/full-episodes/?$)", "/shows/\1");
      error 701 req.url;
    }
    elsif (req.url ~ "^/movies/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+)/(.*)/?$") {
      set req.url = regsub(req.url, "^/movies/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+)/(.*)/?$", "/shows/\1/videos/\4");
      error 701 req.url;
    }
    elsif (req.url ~ "^/movies/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+).*") {
      set req.url = regsub(req.url, "^/movies/([a-z0-9-]+)/video/season-([0-9-]+)/episode-([0-9-]+).*", "/shows/\1/season-\2/episode-\3");
      error 701 req.url;
    }
    elsif (req.url ~ "^/movies/([a-z0-9-]+)/video/([a-z0-9-]+)/season-([0-9-]+)/episode-([0-9-]+)/(.*)$") {
      set req.url = regsub(req.url, "^/movies/([a-z0-9-]+)/video/([a-z0-9-]+)/season-([0-9-]+)/episode-([0-9-]+)/(.*)$", "/shows/\1/videos/\5");
      error 701 req.url;
    }
    elsif (req.url ~ "^/movies/([a-z0-9-]+)/video/(.*)$") {
      set req.url = regsub(req.url, "^/movies/([a-z0-9-]+)/video/(.*)$", "/movies/\1/full-movie");
      error 701 req.url;
    }
    elsif (req.url ~ "^/movies/([a-z0-9-]+)/episodes/?($|.*$)") {
      set req.url = regsub(req.url, "^/movies/([a-z0-9-]+)/episodes/?($|.*$)", "/shows/\1");
      error 701 req.url;
    }
    elsif (req.url ~ "^/movies/([a-z0-9-]+)/video/([a-z0-9-\?]+)") {
      set req.url = regsub(req.url, "/movies/([a-z0-9-]+)/video/([a-z0-9-\?]+)", "/movies/\1/full-movie");
      error 701 req.url;
    }
    elsif (req.url.path ~ "^/shows/bring-it/photos/?$") {
      if (req.url.qs ~ "^$") {
        set req.url = "/shows/bring-it/pictures";
      } else {
          set req.url = "/shows/bring-it/pictures" "?" req.url.qs;
      }
      error 701 req.url;
    }
    elsif (req.url.path ~ "^/roku-channel$") {
      if (req.url.qs ~ "^$") {
        set req.url = "/roku-app";
      } else {
          set req.url = "/roku-app" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/support") {
        set req.http.Host = "mylifetime.zendesk.com";
        set req.url = "/hc/en-us";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/innercircle") {
        set req.http.Host = "innercircle.mylifetime.com";
        set req.url = "/welcome" + if(req.url.qs, "?" + req.url.qs, "");
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/video/watch-app-faq") {
        set req.http.Host = "mylifetime.zendesk.com";
        set req.url = "/hc/en-us/categories/202552577-Watch-App" + if(req.url.qs, "?" + req.url.qs, "");
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/beaches") {
        set req.http.Host = "www.hsn.com";
        set req.url = "/shop/beaches/16033?sourcemailid=DCBeaches" + if(req.url.qs, "&" + req.url.qs, "");
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/movies/escaping-polygamy") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + ".aetv.com", "www.aetv.com");
        set req.url = "/shows/escaping-polygamy" + if(req.url.qs, "?" + req.url.qs, "");
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/(autherize|active|authorise|authorize|activation|autorize|actvate|authoize)/?") {
        set req.url = "/activate";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/dance-moms/exclusives/music-guide/?") {
        set req.url = "/shows/dance-moms";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/bring-it/exclusives/music-guide/?") {
        set req.url = "/shows/bring-it";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/SammysWay/?") {
        set req.url = "/shows/project-runway/playlist/project-runway-season-15-curated-list";
        error 701 req.url;
    }

    if (req.url ~ "^/(about-us|about-us/support)") {
        set req.http.Host = "mylifetime.zendesk.com";
        set req.url = "/hc/en-us";
        error 701 req.url;
    }

    if (req.url.path ~ "/favicon.ico") {
        set req.url = "/assets/images/lifetime/favicon.ico";
    }

    if (req.url.path ~ "(?i)^/shows/bringing-up-ballers/?") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/win/?$") {
        set req.http.Host = "sweepstakes.mylifetime.com";
        set req.url = "/fbsweeps/sweeps/Bring-It-Live-Sweepstakes?cmpid=redirect";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/lifetime-movie-club/?$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".lifetimemovieclub.com", "www.lifetimemovieclub.com");
        set req.url = "/";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/chloe/?$") {
        set req.url = "/shows/dance-moms/playlist/chloes-favorite-episodes?intcmp=TV_P717_DM";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/lafavorites/?$") {
        set req.url = "/shows/little-women-la/playlist/fan-favorite-episodes?intcmp=TV_P717_LWLA";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/ddp/?$") {
        set req.url = "/shows/bring-it/playlist/dynamic-ddp?intcmp=TV_P717_BI";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/little-women-la-couples-retreat/?$") {
        set req.url = "/shows/little-women-la";
        error 701 req.url;
    }

    if (req.url ~ "(?i)^/specials/american-murder-house(/?|$)") {
        set req.url = "/lmn/shows";
        error 701 req.url;
    }

    if (req.url ~ "(?i)^/specials/deadly-secrets-the-lost-children-of-dozier(/?|$)") {
        set req.url = "/lmn/shows";
        error 701 req.url;
    }

    if (req.url ~ "(?i)^/specials/my-uncle-is-the-green-river-killer(/?|$)") {
        set req.url = "/lmn/shows";
        error 701 req.url;
    }

    if (req.url ~ "(?i)^/specials/10th-date-girls-night-in(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/30-something-grandma(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url ~ "(?i)^/specials/beaches-the-after-party(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/bristol-palin-lifes-a-tripp(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/abbys-studio-rescue(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/dance-mums-uk(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/fashionably-late-with-rachel-zoe(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/specials/i-am-britney-jean(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/specials/jonbenets-mother-victim-or-killer(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/specials/joyce-mitchell-and-the-new-york-prison-break(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/knocked-up(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/kosher-soul(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/little-weddings(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/pitch-slapped(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/smile(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/the-jacksons-next-generation(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/specials/the-real-amish-witches(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/the-view-live-election-special(/?|$)") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/kosher-soul$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/little-weddings$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/pitch-slapped$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/smile$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/the-jacksons-next-generation$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/specials/the-real-amish-witches$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/the-view-live-election-special$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shows/women-of-honor$") {
        set req.url = "/shows";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/prize") {
        set req.http.Host = "sweepstakes.mylifetime.com";
        set req.url = "/fbsweeps/sweeps/Lifetime-Movies-Summer-Sweepstakes?cmpid=o_onair_lm_snipe";
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

    if (req.url.path ~ "^/shows/i-survived-beyond-and-back/?$") {
        set req.url = "/lmn/shows";
        error 701 req.url;
    }
    if (req.url.path ~ "^/shows/my-ghost-story-caught-on-camera/?$") {
        set req.url = "/lmn/shows";
        error 701 req.url;
    }
    if (req.url.path ~ "^/firstflightcasting") {
        set req.http.Host = "www.pilgrimstudios.com";
        set req.url = "/casting/firstflight";
        error 701 req.url;
    }
    if (req.url.path ~ "^/innercircle") {
        set req.http.Host = "signup-innercircle.mylifetime.com";
        set req.url = "/holiday";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/escapetheboardsweeps") {
        set req.http.Host = "sweepstakes.mylifetime.com";
        set req.url = "/fbsweeps/sweeps/Escape-the-Board-Sweepstakes";
        error 701 req.url;
    }
    if (req.url.path ~ "(?i)^/join") {
        set req.http.Host = "innercircle.mylifetime.com";
        set req.url = "/welcome?utm_source=linear&utm_medium=lifetime&utm_campaign=snipe&cmpid=o_onair_lt_snipe";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/WatchYOUandWin$") {
        set req.url = "/shows/you/pages/watch-and-win";
        error 701 req.url;
    }
    if (req.url.path ~ "^/holidaysweepsrules") {
        set req.http.Host = "innercircle.mylifetime.com";
        set req.url = "/sweepstakes/holiday-sweepstakes";
        error 701 req.url;
    }
    if (req.url.path ~ "^/WonderfulLifetimeSongs") {
        set req.http.Host = "open.spotify.com";
        set req.url = "/album/6l5feEGbFGvxJq2rmsdsBB?si=KHSdkX_UTwCR4pxIgKea9w";
        error 701 req.url;
    }
    if (req.url.path ~ "(?i)^/2019lmcrules" && req.url.path != "/2019lmcrules") {
        set req.url = "/2019lmcrules";
        error 701 req.url;
    }
    if (req.url.path ~ "(?i)^/santa" && req.url.path != "/santa") {
        set req.url = "/santa";
    }
    if (req.url.path ~ "^/shows/project-runway-all-stars/project-runway-all-stars-misc($|\/.*)") {
        set req.url = "/shows/project-runway-all-stars";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/kayla" && req.url.path != "/kayla") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + "-play.mylifetime.com", "play.mylifetime.com");
        set req.url = "/list/keeping-up-with-kayla";
        error 701 req.url;
    }

    if (req.url.path ~ "^/movies/the-wrong-house-sitter/preview-the-wrong-house-sitter") {
        set req.url = "/movies/the-wrong-housesitter/preview-the-wrong-house-sitter";
        error 701 req.url;
    }

    if (req.http.AETN-env ~ "(DEV|QA)" && req.url.path ~ "^/embed/(\d+)$") {
      set req.url = regsub(req.url.path, "/embed/(\d+)", "/embed.html") "?" "id=" regsub(req.url.path, "/embed/", "") "&" req.url.qs;
      call aetn_player_proxypass;
    }

    if (req.url.path ~ "^/inspiringwomen") {
      set req.http.X-Redirect = "https://play.mylifetime.com/list/inspiring-women-playlist";
      error 703 req.http.X-Redirect;
    }

    if (req.url.path ~ "(?i)^/freetvforme" && req.url.path != "/freetvforme") {
        set req.url = "/freetvforme";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/holidayrecipes" && req.url.path != "/holidayrecipes") {
        set req.url = "/holidayrecipes";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/maryj" && req.url.path != "/maryj") {
        set req.url = "/maryj";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/mafspoll" && req.url.path != "/mafspoll") {
        set req.url = "/mafspoll";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/readingofalifetimerules" && req.url.path != "/readingofalifetimerules") {
        set req.url = "/readingofalifetimerules";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/readingofalifetimesweeps" && req.url.path != "/readingofalifetimesweeps") {
        set req.url = "/readingofalifetimesweeps";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/wendywilliams" && req.url.path != "/wendywilliams") {
        set req.url = "/wendywilliams";
        error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/watchripped$") {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env) + "-play.mylifetime.com", "play.mylifetime.com");
        set req.url = "/list/rfhplaylist/?cmpid=LT_O_Site_L_InfluencerCampaign" + if(req.url.qs, "&" + req.url.qs, "");
        error 701 req.url;
    }
    if (req.http.AETN-env ~ "DEV" || req.http.AETN-env ~ "QA") {
    if (std.prefixof(req.url.path, "/videos/open-swim-in-the-ocean")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.mylifetime.com", "play.mylifetime.com");
      set req.url = "/videos/open-swim-in-the-ocean";
      error 701 req.url;
    }
  }

}
