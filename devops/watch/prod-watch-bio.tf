resource "ultradns_rdpool" "a-bio-com" {
  zone_name   = "bio.com"
  record_type = "A"
  owner_name  = "bio.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-bio-com" {
  zone_name   = "bio.com"
  record_type = "AAAA"
  owner_name  = "bio.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}