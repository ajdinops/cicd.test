sub aetn_service_cache_fetch {
  if (beresp.status == 302 && (bereq.url ~ "^/account($|.*$)" || bereq.url ~ "^/purchase($|.*$)" || bereq.url ~ "^/redeem($|.*$)")) {
      return (pass);
  }
}