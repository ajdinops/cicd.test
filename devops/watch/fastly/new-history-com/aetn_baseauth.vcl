sub aetn_baseauth {
  if ( (!req.http.fastly-ff) && (! table.lookup(customer_token, digest.hash_sha256(req.http.Authorization))) ) {
    error 401 "Restricted";
  }
}