resource "ultradns_rdpool" "a-history-com" {
  zone_name   = "history.com"
  record_type = "A"
  owner_name  = "history.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-history-com" {
  zone_name   = "history.com"
  record_type = "AAAA"
  owner_name  = "history.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-auth-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "auth.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-military-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "military.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-now-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "now.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-preview-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "preview.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-roots-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "roots.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-shop-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "shop.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "www.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-new-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "new.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-jp-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "www.jp.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-historyenespanol-com" {
  zone_name   = "historyenespanol.com"
  record_type = "A"
  owner_name  = "historyenespanol.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-historyenespanol-com" {
  zone_name   = "historyenespanol.com"
  record_type = "AAAA"
  owner_name  = "historyenespanol.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-historyenespanol-com" {
  zone_name   = "historyenespanol.com"
  record_type = "CNAME"
  owner_name  = "www.historyenespanol.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-auth-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-auth.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-military-history-com-1" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-military.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-now-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-now.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-preview-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-preview.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-roots-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-roots.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-shop-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-shop.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-new-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-new.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-jp-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev.jp.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-historyenespanol-com" {
  zone_name   = "historyenespanol.com"
  record_type = "CNAME"
  owner_name  = "dev.historyenespanol.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-auth-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa-auth.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-military-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa-military.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-now-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa-now.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-preview-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa-preview.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-roots-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa-roots.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-shop-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa-shop.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-new-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa-new.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-jp-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "qa.jp.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-historyenespanol-com" {
  zone_name   = "historyenespanol.com"
  record_type = "CNAME"
  owner_name  = "qa.historyenespanol.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}
