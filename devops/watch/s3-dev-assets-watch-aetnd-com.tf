module "dev-assets-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "dev-assets-watch-aetnd-com"
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
    target_prefix = "dev-assets-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/dev-assets-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "dev-assets-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Public"
    "aetn:dataConsumer"          = "Fastly"
    "aetn:dataOrigin"            = "Push"
    "aetn:env"                   = "dev"
    "aetn:hostnames"             = "dev-assets-watch-aetnd-com"
    "aetn:s3Template"            = "Custom-CORS"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "dev-assets-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//ultraDNS
resource "ultradns_record" "cname-dev-aecrimecentral-com" {
  zone_name   = "aecrimecentral.com"
  record_type = "CNAME"
  owner_name  = "dev.aecrimecentral.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-biography-origin-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "dev-biography-origin.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-beardyourself-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev-beardyourself.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-community-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev-community.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-damien-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev-damien.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-preview-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev-preview.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-robertsonfamily-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev-robertsonfamily.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-shop-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev-shop.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-ci-tv" {
  zone_name   = "ci.tv"
  record_type = "CNAME"
  owner_name  = "dev.ci.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-crimeandinvestigationnetwork-com" {
  zone_name   = "crimeandinvestigationnetwork.com"
  record_type = "CNAME"
  owner_name  = "dev.crimeandinvestigationnetwork.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-mafsmash-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "dev-mafsmash.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-preview-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "dev-preview.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "dev.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-historyvault-com" {
  zone_name   = "historyvault.com"
  record_type = "CNAME"
  owner_name  = "dev.historyvault.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-lifetimemovieclub-com" {
  zone_name   = "lifetimemovieclub.com"
  record_type = "CNAME"
  owner_name  = "dev.lifetimemovieclub.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-lookevencloser-com" {
  zone_name   = "lookevencloser.com"
  record_type = "CNAME"
  owner_name  = "dev.lookevencloser.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}