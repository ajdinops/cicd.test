module "qa-assets-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "qa-assets-watch-aetnd-com"
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
    target_prefix = "qa-assets-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/qa-assets-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "qa-assets-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Public"
    "aetn:dataConsumer"          = "Fastly"
    "aetn:dataOrigin"            = "Push"
    "aetn:env"                   = "qa"
    "aetn:hostnames"             = "qa-assets-watch-aetnd-com"
    "aetn:s3Template"            = "Custom-CORS"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "qa-assets-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//UltraDNS
resource "ultradns_record" "cname-qa-aecrimecentral-com" {
  zone_name   = "aecrimecentral.com"
  record_type = "CNAME"
  owner_name  = "qa.aecrimecentral.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-biography-origin-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "qa-biography-origin.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-beardyourself-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa-beardyourself.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-community-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa-community.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-damien-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa-damien.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-preview-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa-preview.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-robertsonfamily-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa-robertsonfamily.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-shop-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa-shop.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-ci-tv" {
  zone_name   = "ci.tv"
  record_type = "CNAME"
  owner_name  = "qa.ci.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-crimeandinvestigationnetwork-com" {
  zone_name   = "crimeandinvestigationnetwork.com"
  record_type = "CNAME"
  owner_name  = "qa.crimeandinvestigationnetwork.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-mafsmash-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "qa-mafsmash.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-preview-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "qa-preview.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "qa.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-historyvault-com" {
  zone_name   = "historyvault.com"
  record_type = "CNAME"
  owner_name  = "qa.historyvault.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-lifetimemovieclub-com" {
  zone_name   = "lifetimemovieclub.com"
  record_type = "CNAME"
  owner_name  = "qa.lifetimemovieclub.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}
