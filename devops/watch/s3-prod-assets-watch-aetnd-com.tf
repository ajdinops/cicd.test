module "prod-assets-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "prod-assets-watch-aetnd-com"
  force_destroy = true
  grant = [{
    display_name = "devops"
    permission   = "FULL_CONTROL"
    type         = "CanonicalUser"
    }, {
    permission = "WRITE"
    id         = null
    type       = "Group"
    uri        = "http://acs.amazonaws.com/groups/s3/LogDelivery"
    }, {
    permission = "READ_ACP"
    id         = null
    type       = "Group"
    uri        = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }]
  owner = {
    display_name = "devops"
  }
  cors_rule = [{
    allowed_headers = ["Authorization"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    id              = ""
    max_age_seconds = 3000
  }]
  lifecycle_rule = [{
    enabled = true
    filter = {
      prefix = ""
    }
    id = "BucketArchivePolicy"
    noncurrent_version_transition = [{
      noncurrent_days = 7
      storage_class   = "GLACIER"
      storage_classs  = false
    }]
  }]
  logging = {
    target_bucket = "logs-s3-433624884903-us-east-1"
    target_prefix = "prod-assets-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/prod-assets-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "prod-assets-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Public"
    "aetn:dataConsumer"          = "Fastly"
    "aetn:dataOrigin"            = "Push"
    "aetn:env"                   = "prod"
    "aetn:hostnames"             = "prod-assets-watch-aetnd-com"
    "aetn:s3Template"            = "Custom-CORS"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "prod-assets-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//ultraDNS
resource "ultradns_rdpool" "a-aecrimecentral-com" {
  zone_name   = "aecrimecentral.com"
  record_type = "A"
  owner_name  = "aecrimecentral.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-aecrimecentral-com" {
  zone_name   = "aecrimecentral.com"
  record_type = "AAAA"
  owner_name  = "aecrimecentral.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-aecrimecentral-com" {
  zone_name   = "aecrimecentral.com"
  record_type = "CNAME"
  owner_name  = "www.aecrimecentral.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-biography-origin-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "biography-origin.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "A"
  owner_name  = "aetv.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "AAAA"
  owner_name  = "aetv.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-beardyourself-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "beardyourself.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-community-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "community.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-damien-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "damien.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-preview-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "preview.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-robertsonfamily-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "robertsonfamily.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-shop-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "shop.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "www.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-ci-tv" {
  zone_name   = "ci.tv"
  record_type = "A"
  owner_name  = "ci.tv."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-ci-tv" {
  zone_name   = "ci.tv"
  record_type = "AAAA"
  owner_name  = "ci.tv."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 86400
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-ci-tv" {
  zone_name   = "ci.tv"
  record_type = "CNAME"
  owner_name  = "www.ci.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-crimeandinvestigationnetwork-com" {
  zone_name   = "crimeandinvestigationnetwork.com"
  record_type = "A"
  owner_name  = "crimeandinvestigationnetwork.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-crimeandinvestigationnetwork-com" {
  zone_name   = "crimeandinvestigationnetwork.com"
  record_type = "AAAA"
  owner_name  = "crimeandinvestigationnetwork.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-crimeandinvestigationnetwork-com" {
  zone_name   = "crimeandinvestigationnetwork.com"
  record_type = "CNAME"
  owner_name  = "www.crimeandinvestigationnetwork.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "A"
  owner_name  = "fyi.tv."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "AAAA"
  owner_name  = "fyi.tv."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-mafsmash-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "mafsmash.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-preview-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "preview.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "www.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-historyvault-com" {
  zone_name   = "historyvault.com"
  record_type = "A"
  owner_name  = "historyvault.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-historyvault-com" {
  zone_name   = "historyvault.com"
  record_type = "AAAA"
  owner_name  = "historyvault.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-preview-historyvault-com" {
  zone_name   = "historyvault.com"
  record_type = "CNAME"
  owner_name  = "preview.historyvault.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-historyvault-com" {
  zone_name   = "historyvault.com"
  record_type = "CNAME"
  owner_name  = "www.historyvault.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-lifetimemovieclub-com" {
  zone_name   = "lifetimemovieclub.com"
  record_type = "A"
  owner_name  = "lifetimemovieclub.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-lifetimemovieclub-com" {
  zone_name   = "lifetimemovieclub.com"
  record_type = "AAAA"
  owner_name  = "lifetimemovieclub.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-preview-lifetimemovieclub-com" {
  zone_name   = "lifetimemovieclub.com"
  record_type = "CNAME"
  owner_name  = "preview.lifetimemovieclub.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-lifetimemovieclub-com" {
  zone_name   = "lifetimemovieclub.com"
  record_type = "CNAME"
  owner_name  = "www.lifetimemovieclub.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-lookevencloser-com" {
  zone_name   = "lookevencloser.com"
  record_type = "CNAME"
  owner_name  = "www.lookevencloser.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}
