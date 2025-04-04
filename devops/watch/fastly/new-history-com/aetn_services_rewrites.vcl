sub aetn_services_rewrites {
    if (req.url ~ "^/feeds/editorial/(.*)$") {
        set req.url = regsub(req.url, "^/feeds/editorial/(.*)$", "/feed/?post_type=\1");
        if (req.url.qs) {
            set req.url = req.url + "&" + req.url.qs;
        }
      set req.backend = F_loki_editorial_aetnd_io;
    }

    if (std.prefixof(std.tolower(req.url.path), "/skinwalkerranchsweeps")) {
      set req.url = std.tolower(req.url.path) + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
    } elsif (std.prefixof(std.tolower(req.url.path), "/ancestrygoat")) {
      set req.url = std.tolower(req.url.path) + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
    } elsif (std.prefixof(std.tolower(req.url.path), "/pawnsweepstakes")) {
      set req.url = std.tolower(req.url.path) + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
    } elsif (std.prefixof(std.tolower(req.url.path), "/alonesheltersweeps")) {
      set req.url = std.tolower(req.url.path) + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
    } elsif (std.prefixof(std.tolower(req.url.path), "/alonesheltersweepsrules")) {
      set req.url = std.tolower(req.url.path) + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
    } elsif (std.prefixof(std.tolower(req.url.path), "/unxnow")) {
      set req.url = std.tolower(req.url.path) + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
    } elsif (std.prefixof(std.tolower(req.url.path), "/unxplainednow")) {
      set req.url = std.tolower(req.url.path) + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
    }

    if (req.url ~ "^/home$") {
      set req.url = "/";
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-auth.history.com", "auth.history.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-military.history.com", "military.history.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
      set req.url = "/military";
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-now.history.com", "now.history.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
      set req.url = "/shop";
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)".jp.history.com", "www.jp.history.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-jp.history.com", "jp.history.com");
      error 701 req.url;
    }


    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-shop.history.com", "shop.history.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
      error 701 req.url;
    }

    set req.http.X-Redirect = table.lookup(redirects_301, std.tolower(req.url));

    if (req.http.AETN-env ~ "DEV" && is_activate_backend()) {
      set req.http.X-Redirect = table.lookup(redirects_301_activate, std.tolower(req.url));
    }

    # checking for non-empty X-Redirect because some of Arena redirects are in redirects_301 table,
    # because it couldn't fit all 11k redirects into redirects_301_arena
    if (req.http.AETN-env !~ "DEV" && is_loki_backend()) {
      if (!req.http.X-Redirect) {
        set req.http.X-Redirect = table.lookup(redirects_301_arena1, std.tolower(req.url));
      }
      if (!req.http.X-Redirect) {
        set req.http.X-Redirect = table.lookup(redirects_301_arena2, std.tolower(req.url));
      }
    }

    if (req.url ~ "^/.amp/.*$") {
      set req.http.X-Redirect = regsub(req.url, "^/.amp/(.*)", "/\1");
    }

    if (req.http.X-Redirect) {
      error 701 req.http.X-Redirect;
    }

    if (req.url !~ "^/embed/(.*)$" && req.url !~ "^/emails/unsubscribe" && req.url !~ "^/build/" && req.url !~ "^/vendor/" && req.url !~ "^/vip/" && req.url !~ "^/assets/") {

      set req.http.X-Redirect = table.lookup(country_redirects_302, std.tolower(req.http.AETN-country-code));

        if (req.http.X-Redirect) {
          error 704 req.http.X-Redirect;
        }

        if (req.http.AETN-country-code == "CA") {

            if (req.url.path == "/") {
              set req.http.X-Redirect = "https://www.history.ca/";
              error 704 req.http.X-Redirect;
            }

            if (req.url.path ~ "/shows/vikings") {
              set req.http.X-Redirect = "https://www.history.ca/vikings";
              error 704 req.http.X-Redirect;
            }
            elsif (req.url.path ~ "/shows/alone") {
              set req.http.X-Redirect = "https://www.history.ca/alone";
              error 704 req.http.X-Redirect;
            }
            elsif (req.url.path ~ "/shows/hunting-hitler") {
              set req.http.X-Redirect = "https://www.history.ca/hunting-hitler";
              error 704 req.http.X-Redirect;
            }
            elsif (req.url.path ~ "/shows/the-curse-of-oak-island") {
              set req.http.X-Redirect = "https://www.history.ca/the-curse-of-oak-island";
              error 704 req.http.X-Redirect;
            }
            elsif (req.url.path ~ "^/(shows|specials|movies|schedule)") {
              set req.http.X-Redirect = "https://www.history.ca/";
              error 704 req.http.X-Redirect;
            }
        }
    }


    if (req.url ~ "^/(games)") {
      set req.http.X-Redirect = "https://www.history.com/";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "^/tag/history-vault") {
      set req.http.X-Redirect = "https://watch.historyvault.com/";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "^/shows/(americas-greatest-prison-breaks|all-you-can-eat|h2-specials|how-2-win|the-human-calculator|the-making-of-trump|the-marijuana-revolution|the-seven-new-signs-of-the-apocolypse|top-guns)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "^/PresidentSweeps") {
      set req.url = "/presidentsweeps";
      error 701 req.url;
    }

    if (req.url ~ "^/TruckSweeps") {
      set req.url = "/trucksweeps";
      error 701 req.url;
    }

    if (req.url ~ "^/PresidentsDayRules") {
      set req.url = "/presidentsdayrules";
      error 701 req.url;
    }

    if (req.url ~ "^/TruckNightRules") {
      set req.url = "/trucknightrules";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/(atlantis\-found|alcatraz\-search\-for\-the\-truth|roanoke\-search\-for\-the\-lost\-colony|nostradamus\-21st\-century\-prophecies\-revealed|bigfoot\-captured|secrets\-of\-einsteins\-brain|roanoke\-search\-for\-the\-lost\-colony)(/?|/)$") {
      set req.url = regsub(req.url, "^/shows/([a-z0-9-_]+)(/?|/(.*))$", "/specials/\1");
      error 701 req.url;
    }


    if (req.url.path ~ "^/shows/(history-films|history-specials|history-honors|classroom)" ||
        req.url.path ~ "^/topics/(1920s|1950s|1960s|1970s|1980s|1990s|19th\-century|21st\-century|aapi|africa|american\-civil\-war|american\-revolution|ancient\-americas|ancient\-china|ancient\-egypt|ancient\-greece|ancient\-middle\-east|ancient\-rome|art\-history|asian\-history|black\-history|christmas|cold\-war|colonial\-america|crime|early\-20th\-century\-us|early\-us|european\-history|exploration|first\-ladies|folklore|food|great\-depression|halloween|hispanic\-history|holidays|holocaust|immigration|industrial\-revolution|inventions|landmarks|latin\-america|lgbtq|middle\-ages|middle\-east|native\-american\-history|natural\-disasters\-and\-environment|pre\-history|religion|renaissance|slavery|space\-exploration|sports|st\-patricks\-day|thanksgiving|united\-states\-constitution|us\-government\-and\-politics|us\-presidents|us\-states|valentines\-day|vietnam\-war|womens\-history|world\-war\-i|world\-war\-ii)$"
    ) {
      # do nothing
    }
    # only rewrite URIs if not in the exclusion list
    else {
        if (req.url.path ~ "^/this-day-in-history/day/(.*)$") {
          set req.url = regsub(req.url, "^/this-day-in-history/day/(.*)", "/this-day-in-history/\1");
          error 701 req.url;
        }
        if (req.url.path ~ "^/this-day-in-history/year/(.*)$") {
          set req.url = regsub(req.url, "^/this-day-in-history/year/(.*)", "/a-year-in-history/\1");
          error 701 req.url;
        }

        if (req.url.path ~ "^/topics/(.*)/(topics|videos|stories|this-day-in-history)$") {
          set req.url = regsub(req.url, "^/topics/(.*)/(topics|videos|stories|this-day-in-history)", "/topics/\1");
          error 701 req.url;
        }
        if (req.url.path ~ "^/topics/(.*)/history-of-video-games$") {
          set req.url = "/articles/history-of-video-games";
          error 701 req.url;
        }
        if (req.url.path ~ "^/topics/(.*)/(.*)video(.*)$") {
          set req.url = regsub(req.url, "^/topics/(.*)/(.*)", "/topics/\1");
          error 701 req.url;
        }
        if (req.url.path ~ "^/topics/(.*)/(.*)$") {
          set req.url = regsub(req.url, "^/topics/(.*)/(.*)", "/articles/\2");
          error 701 req.url;
        }
        if (req.url.path ~ "^/topics/(.*)") {
          set req.url = regsub(req.url, "^/topics/(.*)", "/articles/\1");
          error 701 req.url;
        }
        
        if (req.url == "/news") {
          set req.url = "/articles";
          error 701 req.url;
        }

        if (req.url.path ~ "^/news/(.*)") {
          set req.url = regsub(req.url, "^/news/(.*)$", "/articles/\1");
          error 701 req.url;
        }

        if (req.url.path ~ "^/author/(.*)") {
          set req.url = regsub(req.url, "^/author/(.*)$", "/authors/\1");
          error 701 req.url;
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
    }

    if (req.url ~ "^/mplclicense$") {
      set req.http.host = "mplclicense.history.com";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/xtreme-off-road$") {
      set req.http.X-Redirect = "https://www.powernationtv.com/shows/xor";
      error 703 req.http.X-Redirect;
    }

    if (req.url.path ~ "^/thelastarchive$") {
      set req.http.X-Redirect = "https://podcasts.apple.com/us/podcast/history-this-week/id1493453604";
      error 703 req.http.X-Redirect;
    }

    if (req.url ~ "^/(shows/detroit-muscle|shows/truck-tech|shows/engine-power)$") {
      set req.http.host = "www.powernationtv.com";
      error 701 req.url;
    }

    if (req.url ~ "^/history-now-facebook-redirect$") {
      set req.url = regsub(req.url, "^/history-now-facebook-redirect$", "/GetHistoryNow");
      set req.http.host = "www.facebook.com";
      error 701 req.url;
    }

    if (req.url ~ "^/history-now-twitter-redirect$") {
      set req.url = regsub(req.url, "^/history-now-twitter-redirect$", "/gethistorynow");
      set req.http.host = "twitter.com";
      error 701 req.url;
    }

    if (req.url ~ "^/courses") {
      set req.url = regsub(req.url, "^/courses(.*)", "\1");
      set req.http.host = "historychannel.ou.edu";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/winsweeps") {
      set req.url = regsub(req.url, "(?i)^/winsweeps", "/campaign/799616");
      set req.http.host = "offerpop.com";
      error 701 req.url;
    }

    if (req.url ~ "^/collegecourses") {
      set req.url = regsub(req.url, "^/collegecourses(.*)", "/college");
      set req.http.host = "historychannel.ou.edu";
      error 701 req.url;
    }

    if (req.url ~ "^/2016courses") {
      set req.url = regsub(req.url, "^/2016courses(.*)", "/lifelearner");
      set req.http.host = "historychannel.ou.edu";
      error 701 req.url;
    }

    if (req.url ~ "^/support") {
      set req.url = regsub(req.url, "^/support(.*)", "/hc/en-us");
      set req.http.host = "history.zendesk.com";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/the-ride-that-got-away") {
      set req.http.Host = "www.fyi.tv";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/barrett-jackson-auction") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv", "www.fyi.tv");
      error 701 req.url;
    }

    if (req.url ~ "^/historyvaultfaq") {
      set req.url = regsub(req.url, "^/historyvaultfaq(.*)", "/hc/en-us/categories/202561328");
      set req.http.host = "history.zendesk.com";
      error 701 req.url;
    }

    if (req.url ~ "/(emails|email)($|/$)") {
      set req.url = "/emails/sign-up";
      error 701 req.url;
    }

    if (req.url ~ "^/roots/fyc$") {
      set req.url = regsub(req.url, "^/roots/fyc$", "");
      set req.http.host = "rootsfyc.aetncsg.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/historyvault($|.*$)" && req.url !~ "/historyvaultrules($|.*$)") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".historyvault.com", "www.historyvault.com");
      set req.url = "/?cmpid=HV_Redirect";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/history-vault($|.*$)") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".historyvault.com", "www.historyvault.com");
      set req.url = "/?cmpid=HV_Redirect";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/pawnstarscasting$") {
      set req.url = "/shows/pawn-stars/articles/want-to-be-on-pawn-stars";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/(autherize|active|authorise|authorize|activation|autorize|actvate|authoize)/?($|.*$)") {
      set req.url = "/activate";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/missiontohonor$") {
      set req.url = "/history-honors";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/historyhonors$") {
      set req.url = "/history-honors";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/nostradamus$") {
      set req.url = "/specials/nostradamus-election-2016";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/PearlHarbor$") {
      set req.url = "/shows/pearl-harbor-the-last-word";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/alonecast$") {
      set req.url = "/shows/alone/cast";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/contestofthevikinggods$") {
      set req.url = "/shows/vikings/interactives/contest-of-the-viking-gods";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/myhistory2016$") {
      set req.url = "/my-history-2016";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/poll$") {
      set req.url = "/specials/this-is-history-2016/pages/this-is-history-2016";
      set req.http.host = "www.history.com";
      error 701 req.url;
    }

    if (req.url.path == "/favicon.ico") {
      set req.url = "/assets/images/history/favicon.ico";
    }

    if (req.url ~ "(?i)^/chum?($|.*$)") {
      set req.url = "/shows/pawn-stars/playlist/best-of-chum?intcmp=TV_P717_PS";
      error 701 req.url;
    }
    if (req.url ~ "(?i)^/win") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/AlienConBaltimoreGalacticSweepstakes-2?cmpid=o_redirect";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/alienconsweeps") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/AlienConBaltimoreGalacticSweepstakes-2?showrules=true";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/bayourules") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/Swamp-People-King-of-the-Bayou-Sweepstakes?showrules=true";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/shows/ozzy-and-jacks-world-detour?($|.*$)") {
      set req.http.X-Redirect = "http://www.aetv.com/shows/ozzy-and-jacks-world-detour";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/oakrules") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/the-trip-to-oak-island-sweepstakes?showrules=true";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/islandtrip") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/The-Trip-to-Oak-Island-Sweepstakes?cmpid=o_onair_h_snipe";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/island-trip") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/The-Trip-to-Oak-Island-Sweepstakes?cmpid=o_onair_h_snipe";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/enter") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/Forged-in-Fire-Forgemaster-Sweepstakes?cmpid=o_tv_h_promo";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "(?i)^/forgedrules") {
      set req.http.X-Redirect = "https://sweepstakes.history.com/fbsweeps/sweeps/Forged-in-Fire-Forgemaster-Sweepstakes?showrules=true";
      error 704 req.http.X-Redirect;
    }

    if (req.url ~ "^/news/category/?($|.*$)") {
      set req.url = regsub(req.url, "/news/category/([a-z0-9-_]+)", "/tags/\1");
      error 701 req.url;
    }

    if (req.url ~ "^/news/(ask-history|hungry-history|history-lists)/category/?($|.*$)") {
      set req.url = regsub(req.url, "/news/([a-z0-9-]+)/category/([a-z0-9-_]+)", "/tags/\2");
      error 701 req.url;
    }

    if (req.url ~ "^/news/(ask-history|hungry-history|history-lists)$") {
      set req.url = regsub(req.url, "/news/([a-z0-9-]+)", "/news");
      error 701 req.url;
    }

    if (req.url ~ "^/news/(ask-history|hungry-history|history-lists)/?($|.*$)") {
      set req.url = regsub(req.url, "/news/([a-z0-9-]+)/([a-z0-9-_]+)", "/news/\2");
      error 701 req.url;
    }

    if (req.url ~ "^/images") {
      set req.http.X-Redirect = "https://images.history.com" req.url;
      error 704 req.http.X-Redirect;
    }

    if (req.http.host == "projectbluebook.com") {
      set req.http.X-Redirect = "https://www.history.com/shows/project-blue-book";
      error 703 req.http.X-Redirect;
    }

    if (req.http.host == "historyenespanol.com") {
      set req.http.X-Redirect = "https://www.history.com/espanol/schedule";
      error 703 req.http.X-Redirect;
    }


    if (req.url ~ "^/shop") {
      set req.http.X-Redirect = "https://www.historystore.com";
      error 703 req.http.X-Redirect;
    }

    if (req.url ~ "^/aliencon") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".historyvault.com", "www.historyvault.com");
      set req.url = "/redeem/aliencon?cmpid=HV_E_Partner_AlienCon";
      error 702 req.url;
    }


    if (req.url ~ "^/GetOutdoors(\/|$)") {
      set req.url = regsub(req.url, "^/GetOutdoors", "/getoutdoors");
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/global-slave-trade-interactive$") {
        set req.url = "/shows/roots";
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/slave-ships-infographic$") {
        set req.url = "/topics/black-history/slavery/infographics/the-anatomy-of-a-slave-ship";
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/identity/(reading-for-roots|know-your-roots-sweepstakes|your-name-is-your-shield)$") {
        set req.url = "/shows/roots";
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/videos$") {
        set req.url = "/shows/roots";
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/cast/crew$") {
        set req.url = regsub(req.url, "^/cast/crew$", "/shows/roots/cast");
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/cast/doctor-william-waller$") {
        set req.url = regsub(req.url, "^/cast/doctor-william-waller$", "/shows/roots/cast/dr-william-waller");
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/cast/([a-z0-9-_]+)$") {
        set req.url = regsub(req.url, "^/cast/([a-z0-9-_]+)$", "/shows/roots/cast/\1");
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/episodes/episode-([0-9]+)$") {
        set req.url = regsub(req.url, "^/episodes/episode-([0-9]+)$", "/shows/roots/season-1/episode-\1");
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-roots.history.com", "roots.history.com") && req.url ~ "^/.*") {
        set req.url = "/shows/roots";
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".history.com", "www.history.com");
        error 701 req.url;
    }

    if (req.url ~ "^/shows/american-enthusiast-drive") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv", "www.fyi.tv");
      set req.url = "/drive";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/american-enthusiast") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv", "www.fyi.tv");
      set req.url = "/outdoors";
      error 701 req.url;
    }

    if (std.tolower(req.url) == "/blades") {
      set req.http.X-Redirect = "https://play.history.com/shows/forged-in-fire/list/sharpest-blades";
      error 703 req.http.X-Redirect;
    }

    if (std.tolower(req.url) == "/theories") {
      set req.http.X-Redirect = "https://play.history.com/shows/the-curse-of-oak-island/list/best-theories";
      error 703 req.http.X-Redirect;
    }

    if (std.tolower(req.url) == "/tmobile") {
      set req.http.X-Redirect = "https://play.history.com/list/hh250-tmobile";
      error 703 req.http.X-Redirect;
    }

    if (req.url.path ~ "(?i)^/activities$"){
      if (req.url.qs ~ "^$") {
       set req.url = "/history-at-home-activities";
      }
      else {
       set req.url = "/history-at-home-activities" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/buildorbust") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      if (req.url.qs ~ "^$") {
       set req.url = "/shows/alone/list/alone-build-or-bust";
      }
      else {
       set req.url = "/shows/alone/list/alone-build-or-bust" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/foodthatbuilt") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/the-food-that-built-america?cmpid=VAN_HISTORY_foodthatbuilt";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/snacksized") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/the-food-that-built-america-snack-sized?cmpid=VAN_HISTORY_snacksized";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/assemblyrequired") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/assembly-required?cmpid=VAN_HISTORY_assemblyrequired";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/forged") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/forged-in-fire?cmpid=VAN_HISTORY_forged";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/drillingdown") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/the-curse-of-oak-island-drilling-down?cmpid=VAN_HISTORY_drillingdown";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/modernmarvels") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/modern-marvels?cmpid=VAN_HISTORY_modernmarvels";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/oakisland") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/the-curse-of-oak-island?cmpid=VAN_HISTORY_oakisland";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/swamppeople") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/swamp-people?cmpid=VAN_HISTORY_swamppeople";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/oakhistory") {
      set req.url = "/shows/the-curse-of-oak-island/articles/what-is-the-history-of-oak-island?cmpid=VAN_HISTORY_oakhistory";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/moneypit") {
      set req.url = "/shows/the-curse-of-oak-island/articles/what-is-the-money-pit?cmpid=VAN_HISTORY_moneypit";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/drayton") {
      set req.url = "/shows/the-curse-of-oak-island/articles/gary-drayton-interview?cmpid=VAN_HISTORY_drayton";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/oakislandtheories") {
      set req.url = "/shows/the-curse-of-oak-island/articles/curse-of-oak-island-top-theories?cmpid=VAN_HISTORY_oakislandtheories";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/oakislandmap") {
      set req.url = "/shows/the-curse-of-oak-island/interactives/curse-of-oak-island-map?cmpid=VAN_HISTORY_oakislandmap";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/shatner") {
      set req.url = "/shows/the-unxplained/articles/william-shatner-interview-the-unxplained?cmpid=VAN_HISTORY_shatner";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/aloneinsider") {
      set req.url = "/emails/single/alone-insider?cmpid=AloneInsider";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/insider") {
      set req.url = "/emails/single/alone-insider?cmpid=Insider";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/legendaryblades") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/shows/forged-in-fire/list/forged-in-fire-legendary-blades";
      if (req.url.qs != "") { set req.url = req.url + "?" + req.url.qs; }
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/specials/shackletons-endurance-the-lost-ice-ship-found") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = regsub(req.url, "(?i)^/specials/shackletons-endurance-the-lost-ice-ship-found", "/shows/historys-greatest-mysteries/season-3/episode-99");
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/storiesthatbuilt") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      if (req.url.qs ~ "^$") {
       set req.url = "/list/the-stories-that-built-america";
      }
      else {
       set req.url = "/list/the-stories-that-built-america" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/ftbarules") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "(?i)^/ftbasweepstakes") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "(?i)^/cursesweeps") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "(?i)^/cursesweepsrules") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "(?i)^/ancientalienssweeps") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "(?i)^/ancientalienssweepsrules") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "(?i)^/alonesweeps") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "^/tags") {
      set req.url = regsub(req.url, "^/tags", "/tag");
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/families") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      if (req.url.qs ~ "^$") {
       set req.url = "/shows/the-families-that-fed-america/list/the-families-that-fed-america";
      }
      else {
       set req.url = "/shows/the-families-that-fed-america/list/the-families-that-fed-america" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url.path ~ "^/FreeTVForMe") {
      set req.url = "/freetvforme";
      error 701 req.url;
    }

    if (req.http.AETN-env ~ "DEV" || req.http.AETN-env ~ "QA") {
    if (std.prefixof(req.url.path, "/videos/heres-why-the-patriot-act-is-so-controversial")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.history.com", "play.history.com");
      set req.url = "/videos/heres-why-the-patriot-act-is-so-controversial";
      error 701 req.url;
    }
  }
}
