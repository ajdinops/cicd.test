sub aetn_services_rewrites {

    # DSOSEC-938 Redirect IE <= 11 users to upgrade message (to block bot traffic)
    if ((req.http.User-Agent ~ "MSIE \d+.0") || (req.http.User-Agent ~ "Trident" && req.http.User-Agent ~ "rv\:11")) {
      if (req.url !~ "^/ie-upgrade-messaging") {
        set req.http.X-Redirect = "/ie-upgrade-messaging";
        error 701 req.http.X-Redirect;
      }
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-beardyourself.aetv.com", "beardyourself.aetv.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com", "www.aetv.com");
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)".lookevencloser.com", "www.lookevencloser.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com", "www.aetv.com");
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-community.aetv.com", "community.aetv.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com", "www.aetv.com");
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-damien.aetv.com", "damien.aetv.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com", "www.aetv.com");
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-robertsonfamily.aetv.com", "robertsonfamily.aetv.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com", "www.aetv.com");
      set req.url = "/shows/duck-dynasty";
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-shop.aetv.com", "shop.aetv.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com", "www.aetv.com");
      error 701 req.url;
    }

    set req.http.X-Redirect = table.lookup(redirects_302, req.url);

    if (req.http.X-Redirect) {
        error 702 req.http.X-Redirect;
    }

    set req.http.X-Redirect = table.lookup(redirects_301, std.tolower(req.url));

    if (req.http.X-Redirect && req.http.X-Redirect != req.url) {
        error 701 req.http.X-Redirect;
    }

    # excluded shows not sent to watch
    if (req.url ~ "^/shows/(ae-indiefilms)") {
        # do nothing
    }

    # only rewrites URIs if not in the exclusion list
    else {
        if (req.url ~ "^/shows/([a-z0-9-]+)/video(/?$|/full-episodes/?$|/clips/?$)") {
          set req.url = regsub(req.url, "/shows/([a-z0-9-]+)/video(/?$|/full-episodes/?$|/clips/?$)", "/shows/\1");
          error 701 req.url;
        }

        if (req.url ~ "^/shows/([a-z0-9-]+)/video/(full-episodes|clips)/season-([0-9-]+)/?$") {
          set req.url = regsub(req.url, "/shows/([a-z0-9-]+)/video/(full-episodes|clips)/season-([0-9-]+)/?$", "/shows/\1/season-\3");
          error 701 req.url;
        }

        if (req.url ~ "^/shows/([a-z0-9-]+)/(episodes|video)/season-([0-9-]+)/?$") {
          set req.url = regsub(req.url, "/shows/([a-z0-9-]+)/(episodes|video)/season-([0-9-]+)/?$", "/shows/\1/season-\3");
          error 701 req.url;
        }

        if (req.url ~ "^/shows/([a-z0-9-]+)/video/([a-z0-9-]+)") {
          set req.url = regsub(req.url, "/shows/([a-z0-9-]+)/video/([a-z0-9-]+)", "/shows/\1/videos/\2");
          error 701 req.url;
        }

        if (req.url ~ "^/shows/([a-z0-9-]+)/episodes/?$") {
          set req.url = regsub(req.url, "/shows/([a-z0-9-]+)/episodes/?$", "/shows/\1");
          error 701 req.url;
        }
    }

    if (req.url ~ "^/(american-hoggers|bad-ink|beyond-scared-straight|billy-the-exterminator|duck-dynasty|flipping-boston|flipping-vegas|hoarders|panic-9-1-1|shipping-wars|storage-wars|storage-wars-new-york|storage-wars-texas|the-first-48|the-governors-wife|the-killer-speaks)/(episode-guide).*") {
      set req.url = regsub(req.url, "^/([a-z0-9-_]+)/(episode-guide).*", "/shows/\1");
      error 701 req.url;
    }

    if (req.url ~ "^/(bates-motel|longmire|the-glades)/(episode-breakdowns).*") {
      set req.url = regsub(req.url, "^/([a-z0-9-_]+)/(episode-breakdowns).*", "/shows/\1");
      error 701 req.url;
    }

    if (req.url ~ "^/(cold_case_files|criminal-minds|criss_angel|paranormal-state|sell_this_house|sell-this-house|the_first_48|the-first-48-missing-persons)/?.*") {
      set req.url = regsub(req.url, "^/([a-z0-9-_]+)/?.*", "/shows/\1");
      error 701 req.url;
    }

    if (req.url ~ "^/(8-minutes|ae-indiefilms|american-haunting|american-hoggers|american-takedown|bad-ink|barryd-treasure|barter-kings|bates-motel|behind-bars-rookie-year|be-the-boss|beyond-scared-straight|big-smo|billy-the-exterminator|brandi-and-jarrod-married-to-the-job|building-nightmares|cement-heads|cosby-the-women-speak|country-bucks|crazy-hearts-nashville|crime-360|criss-angel-mindfreak|critics-choice|critics-choice-tv-awards|cursed-the-bell-witch|damien|dead-again|disaster-guy|dogs-of-war|dog-the-bounty-hunter|donnie-loves-jenny|dont-trust-andrew-mayne|duck-commander-before-the-dynasty|duck-dynasty|epic-ink|fear-buried-alive|fix-this-yard|flipping-boston|flipping-vegas|flip-this-house|fugitive-chronicles|gene-simmons-family-jewels|godfather-of-pittsburgh|hoarders|intervention|jacked-auto-theft-task-force|lacheys-bar|limo-wars-las-vegas|lone-star-lady|longmire|love-prison|manhunters-fugitive-task-force|married-at-first-sight|money-pit|neighbors-with-benefits|nightwatch|occ-american-xtreme|oj-speaks-the-hidden-tapes|one-voice-concert|panic-9-1-1|parking-wars|rodeo-girls|sell-this-house-extreme|sexy-beasts|shipping-wars|storage-wars|storage-wars-miami|storage-wars-new-york|storage-wars-texas|surviving-marriage|the-enfield-haunting|the-first-48|the-glades|the-governors-wife|the-killer-speaks|the-returned|the-squad-prison-police|those-who-kill|unforgettable|wahlburgers|wild-transport)($|\/.*)") {
      set req.url = regsub(req.url, "/([a-z0-9-]+)($|\/.*$)", "/shows/\1\2");
      error 701 req.url;
    }

    if (req.url ~ "^/(ncta|terms_of_service.jsp)") {
      set req.http.host = "www.aenetworks.com";
      set req.url = "/terms";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/(gangland-undercover)/?($|.*$)") {
      set req.http.host = "www.history.com";
      set req.url = "/shows/gangland-undercover";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/(married-at-first-sight)/?($|.*$)") {
      set req.http.host = "www.mylifetime.com";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/intervention/(participate|participate\/index.jsp)") {
      set req.http.host = "www.submityourlovedone.com";
      set req.url = "/";
      error 701 req.url;
    }

    if (req.url ~ "^/rules") {
      set req.http.host = "aetv.votigo.com";
      set req.url = "/sections/showsweeprules/Live-Pd-Nation-Sweepstakes/eng";
      error 702 req.url;
    }

    if (req.url ~ "^/shows/food-quest") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv","www.fyi.tv");
      set req.url = "/shows/food-quest";
      error 701 req.url;
    }

    if (req.url ~ "^(/shows/|/)(100-makeover|100-dollar-makeover|american_justice|bag-of-bones|be-the-boss|bigspender|bonnie-and-clyde|bordertown-laredo|breakout-kings|cajun-justice|city_confidential|coma|csi_miami|csi-miami|dallas_swat|disaster-guy|drill-team|drivingforce|driving-vegas|extreme-paranormal|findanddesign|fix-this-kitchen|flight_93|flipped-off|flipping-san-diego|fugitive-chronicles|growing-up-gotti|growing-up-twisted|hammertime|hideous-houses|inked|jacked|keyshawn-johnson-tackling-design|kingofcars|lady-hoggers|last-chance-driving-school|MI5|modern-dads|monster-in-laws|montecito|obsessed|paranormal-cops|portraits-from-ground-zero|private-sessions|psychic-tia|random1|relapse|rocco-gets-real|rookies|runaway-squad|southie-rules|strange-days-with-bob-saget|swat|tattoo-highway|teach-tony-danza|the-beast|the-big-fix|the-cleaner|the-exterminators|the-hasselhoffs|the-jacksons-a-family-dynasty|the-peacemaker|the-recovery-project|thesopranos|the-sopranos|the-squad-prison-police|the-two-coreys|think-tank|we-mean-business|breaking-boston|cement-heads|criminal-minds|damien|dead-again|dont-trust-andrew-mayne|fear-buried-alive|godfather-of-pittsburgh|lone-star-lady|longmire|love-prison|neighbors-with-benefits|rodeo-girls|sexy-beasts|the-enfield-haunting|the-glades|the-governors-wife|the-returned|unforgettable|what-would-you-do|who-is-donald-trump)/?") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "^(/specials/|/)(the-22nd-annual-critics-choice-awards|the-21st-annual-critics-choice-awards|critics-choice-tv-awards|critics-choice|dope-man)/?") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "^/(emails|email)($|/$)") {
      set req.url = "/emails/sign-up";
      error 701 req.url;
    }
    elsif (req.url ~ "^/email-updates") {
      set req.url = "/emails/sign-up?cmpid=Social_Email";
      error 701 req.url;
    }

    if (req.url ~ "^/(support|global\/feedback|global\/feedback\/contact.jsp)") {
      set req.http.Host = "aetn.zendesk.com";
      set req.url = "/hc/en-us";
      error 701 req.url;
    }

    if (req.url ~ "^/corporate_privacy_policy.jsp") {
      set req.http.Host = "www.aenetworks.com";
      set req.url = "/privacy";
      error 701 req.url;
    }

    if (req.url ~ "^/tv_parental_guidelines.jsp") {
      set req.http.Host = "www.aenetworks.com";
      set req.url = "/guidelines";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/jep-and-jessica-growing-the-dynasty(.*)") {
      set req.url = regsub(req.url, "/shows/jep-and-jessica-growing-the-dynasty(.*)", "/shows/jep-jessica-growing-the-dynasty\1");
      error 701 req.url;
    }

    if (req.url ~ "^/(games|real-life-change|reallifechange)/?($|.*$)") {
      set req.url = "/";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/(real-life-change|escaping-the-kkk)/?($|.*$)") {
      set req.url = "/";
      error 701 req.url;
    }

    if (req.url ~ "^/(UniversalSweeps|Universalsweeps)$") {
      set req.url = "/universalsweeps";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/(autherize|active|authorise|authorize|activation|autorize|actvate|authoize)/?($|.*$)") {
      set req.url = "/activate";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/sell-this-house-extreme/pictures?($|.*$)") {
      set req.url = "/shows/sell-this-house-extreme";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/generation-kkk(.*)") {
      set req.url = regsub(req.url, "/shows/generation-kkk(.*)", "/shows/escaping-the-kkk\1");
      error 701 req.url;
    }

    if (req.url ~ "^/bigassbrandbook") {
      set req.http.Host = "aebabb.aetncsg.com";
      set req.url = "/";
      error 701 req.url;
    }

    if (req.url ~ "^/gifsforgood") {
      set req.http.Host = "gifsforgood.aetv.com";
      set req.url = "/";
      error 701 req.url;
    }

    if (req.url.path == "/favicon.ico") {
      set req.url = "/assets/images/aetv/favicon.ico";
    }

    if (req.url ~ "^/specials/the-killing-of-jonbenet-the-truth-uncovered?($|.*$)") {
      set req.url = "/specials/the-killing-of-jonbenet-her-father-speaks";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/akil?($|.*$)") {
      set req.url = "/shows/akil-the-fugitive-hunter";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/lowe?($|.*$)") {
      set req.url = "/shows/the-lowe-files";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/thelowe?($|.*$)") {
      set req.url = "/shows/the-lowe-files";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/kids?($|.*$)") {
      set req.url = "/shows/duck-dynasty/playlist/duck-dynasty-best-of-the-robertson-kids-playlist?intcmp=TV_P717_DD";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/drugskill?($|.*$)") {
      set req.url = "/shows/the-first-48/playlist/the-first-48-drugs-kill?intcmp=TV_P717_TF48";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/akil-the-fugitive-hunter/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "^/(the-eleven|theeleven|eleven|the-11|the11|11)") {
      set req.url = "/shows/the-eleven";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/american-hoggers/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/american-takedown/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/bad-ink/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/black-and-white/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/country-bucks/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/cursed-the-bell-witch/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/dogs-of-war/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/dont-trust-andrew-mayne/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/epic-ink/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/heavy/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/lacheys-bar/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (std.prefixof(std.tolower(req.url.path), "/stonecoldquiz")) {
      set req.url = "/shows/stone-cold-takes-on-america/interactives/stone-cold-trivia-quiz" + if(std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/shows/wild-transport/?($|.*$)") {
      set req.url = "/shows";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/marcia?($|.*$)") {
      set req.url = "/shows/marcia-clark-investigates-the-first-48";
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

    if (req.url ~ "^/shows/escaping-polygamy/?($|.*$)") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".mylifetime.com", "www.mylifetime.com");
      set req.url = "/shows/escaping-polygamy";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/(thedevilnextdoor|the-devil-next-door|devilnextdoor|devil-next-door)(\?.*)?$") {
      set req.url = "/shows/the-devil-next-door";
      error 701 req.url;
    }

    if (req.url ~ "^/shows/scraps") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv", "www.fyi.tv");
      error 701 req.url;
    }

    if (req.url.path ~ "^/the-table-is-ours($|\/$)") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".mylifetime.com", "www.mylifetime.com");
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/(the-clinton-affair|theclintonaffair|clinton-affair|clintonaffair)(\?.*)?$") {
      set req.url = "/shows/the-clinton-affair";
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/bobbybrownsongsweepstakes$") {
      set req.url = std.tolower(req.url);
    }

    if (req.url.path ~ "(?i)^/musicfanartsweepstakess$") {
      set req.url = std.tolower(req.url);
    }

    if (req.url.path ~ "(?i)^/cakedynastycontest$") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "(?i)^/wweonaecontest") {
      set req.url = std.tolower(req.url);
    }

    if (req.url ~ "^/a\-and\-e\-video\-faq") {
      set req.http.X-Redirect = "https://support.aetv.com";
      error 703 req.http.X-Redirect;
    }

    if (req.url.path ~ "(?i)^/wwesweeps$") {
      set req.url = regsub(req.url, "(?i)^/wwesweeps", "/aewwemeetandgreetsweeps");
      error 701 req.url;
    }

    if (req.url.path ~ "(?i)^/wwesweepsrules$") {
      set req.url = regsub(req.url, "(?i)^/wwesweepsrules", "/aewwemeetandgreetrules");
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/aewwemeetandgreetsweeps") {
      set req.url = std.tolower(req.url);
    }

    if (req.url.path ~ "(?i)^/topdogsweepstakes") {
      set req.http.X-Redirect = "https://www.topdogsweeps.com/";
      error 703 req.http.X-Redirect;
    }

    if (req.url.path ~ "^/shows/sell-this-house$") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".fyi.tv", "www.fyi.tv");
      error 701 req.url;
    }

    if (req.url ~ "^/(movingforward|moving-forward)$") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.aetv.com", "play.aetv.com");
      set req.url = "/list/moving-forward";
      error 701 req.url;
    }

    if (req.url ~ "^/(AmericasTopDogContest|americas-top-dog-contest)$") {
      set req.url = "/americastopdogcontest";
      error 701 req.url;
    }

    if (req.url ~ "^/(tappingout|TappingOut)$") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.aetv.com", "play.aetv.com");
      set req.url = "/list/tapping-out-full-episodes";
      error 701 req.url;
    }

    if (req.http.host == if(req.http.AETN-env, std.tolower(req.http.AETN-env)".lookevencloser.com", "www.lookevencloser.com")) {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)".aetv.com ", "www.aetv.com ");
    }

    if (req.url.path ~ "(?i)^/wrongcrowd") {
      set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.aetv.com", "play.aetv.com");
      if (req.url.qs ~ "^$") {
        set req.url = "/shows/beyond-scared-straight/list/the-wrong-crowd";
      } else {
        set req.url = "/shows/beyond-scared-straight/list/the-wrong-crowd" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url.path ~ "^/LivePD300thEpisodeSweepsRules") {
      if (req.url.qs ~ "^$") {
        set req.url = "/livepd300thepisodesweepsrules";
      } else {
        set req.url = "/livepd300thepisodesweepsrules" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url.path ~ "^/(LivePD300thEpisodeSweeps|300)") {
      if (req.url.qs ~ "^$") {
        set req.url = "/livepd300thepisodesweeps";
      } else {
        set req.url = "/livepd300thepisodesweeps" "?" req.url.qs;
      }
      error 701 req.url;
    }

    if (req.url.path ~ "^/(VoicesMagnified|voices-magnified)") {
      set req.url = "/voicesmagnified";
      error 701 req.url;
    }

    if (req.url ~ "(?i)^/iamkisscontest") {
      set req.url = std.tolower(req.url);
    }

    if (req.http.AETN-env ~ "(DEV|QA)" && req.url.path ~ "^/embed/(\d+)$") {
      set req.url = regsub(req.url.path, "/embed/(\d+)", "/embed.html") "?" "id=" regsub(req.url.path, "/embed/", "") "&" req.url.qs;
      call aetn_player_proxypass;
    }

    if (req.url.path ~ "^/FreeTVForMe") {
      set req.url = "/freetvforme";
      error 701 req.url;
    }

    if (req.url.path ~ "^/WWEonAESweeps") {
      set req.url = "/wweonaesweeps";
      error 701 req.url;
    }

    if (req.http.host == "duckdynastyrevival.com") {
      set req.http.X-Redirect = "https://www." req.http.host req.url;
      error 703 req.http.X-Redirect;
    }

    if (req.http.host == "duckdynastytherevival.com") {
      set req.http.X-Redirect = "https://www." req.http.host req.url;
      error 703 req.http.X-Redirect;
    }

    if (req.http.host == "www.duckdynastyrevival.com") {
      set req.http.X-Redirect = "https://www.aetv.com/shows/duck-dynasty-the-revival";
      error 703 req.http.X-Redirect;
    }

    if (req.http.host == "www.duckdynastytherevival.com") {
      set req.http.X-Redirect = "https://www.aetv.com/shows/duck-dynasty-the-revival";
      error 703 req.http.X-Redirect;
    }

    if (req.url.path ~ "(?i)/therealestatecommission") {
    set req.url = "/shows/the-real-estate-commission-master-broker";
    error 701 req.url;
  }
    if (req.http.AETN-env ~ "DEV" || req.http.AETN-env ~ "QA") {
      if (std.prefixof(req.url.path, "/videos/biography-presents-santa-claus")) {
        set req.http.host = if(req.http.AETN-env, std.tolower(req.http.AETN-env)"-play.aetv.com", "play.aetv.com");
        set req.url = "/videos/biography-presents-santa-claus";
        error 701 req.url;
    }
  }
}
