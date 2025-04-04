include "sigsci_config"

sub vcl_recv {
    # FASTLY recv
	
    /* Condition to not accept client IP headers from edge */
    if (fastly.ff.visits_this_service == 0 && req.restarts == 0) {
        set req.http.Fastly-Client-IP = client.ip;
    }

    /* Generate unique request ID to correlate w/ WAF and backend logs */
    set req.http.X-Request-ID = digest.hash_sha256(now randomstr(64) req.http.host req.url req.http.Fastly-Client-IP server.identity);

    /* The below if condition is to deny the .bak requests an attacker is trying to scan against this server, as these attacks are causing 503 spikes on our service. */
    if (req.url.path ~ "\.bak") {
        error 404 "Not Found";
    }

    call aetn_check_shield_recv;
    call aetn_set_env_recv;
    call aetn_device_recv;
    call aetn_geo_recv;

    # Setting the header to preserve the original request to use it elsewhere
    set req.http.host1 = req.http.host;

    call aetn_services_recv;
    call aetn_monitoring_check_recv;

    if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
        return(pass);
    }

    if (req.request == "FASTLYPURGE") {
        set req.http.Fastly-Purge-Requires-Auth = "1";
    }

    /* Token authentication is enabled only for those services that set the header AETN-tokenauth to True within the respective aetn_services_recv */
    if (req.http.AETN-tokenauth == "true") {
        call aetn_token_auth;
    }

    return(lookup);
}

sub vcl_fetch {
	call aetn_stale_fetch;

#FASTLY fetch

	if ((beresp.status == 500 || beresp.status == 503) && req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
		restart;
	}

	if(req.restarts > 0 ) {
		set beresp.http.Fastly-Restarts = req.restarts;
	}


	if (beresp.http.Cache-Control ~ "private") {
		set req.http.Fastly-Cachetype = "PRIVATE";
		return (pass);
	}

	if (beresp.status == 500 || beresp.status == 503) {
		set req.http.Fastly-Cachetype = "ERROR";
		set beresp.ttl = 1s;
		set beresp.grace = 5s;
		return (deliver);
	}

	call aetn_cache_fetch;
	call aetn_gzip_fetch;
	call aetn_debug_fetch;
	call aetn_service_cache_fetch;

	return(deliver);
}

sub vcl_hit {
	#FASTLY hit

	if (!obj.cacheable) {
		return(pass);
	}
	return(deliver);
}

sub vcl_miss {
	call aetn_shield;
    call edge_security;
	#FASTLY miss
	return(fetch);
}

sub vcl_deliver {

	# Unsetting the header we have set in the recv function
	unset req.http.host1;

	call aetn_stale_deliver;

	#FASTLY deliver

	call aetn_deliver;

	return(deliver);
}

sub vcl_error {
	call aetn_error;
	call aetn_stale_error;
	#FASTLY error
}

sub vcl_pass {
	call aetn_shield;
	call edge_security;
	#FASTLY pass
}

sub vcl_hash {
	set req.hash += req.url;
	set req.hash += req.http.host;
	set req.hash += req.vcl.generation;
	#FASTLY hash
	return (hash);
}