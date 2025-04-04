module "qa-editorials-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "qa-editorials-watch-aetnd-com"
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
    target_prefix = "qa-editorials-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/qa-editorials-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "qa-editorials-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Public"
    "aetn:dataConsumer"          = "Fastly"
    "aetn:dataOrigin"            = "EC2"
    "aetn:env"                   = "qa"
    "aetn:hostnames"             = "qa-editorials-watch-aetnd-com"
    "aetn:s3Template"            = "Webhosting Publishing"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "qa-editorials-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//UltraDNS Records
resource "ultradns_record" "cname-qa-livelyplace-com" {
  zone_name   = "livelyplace.com"
  record_type = "CNAME"
  owner_name  = "qa.livelyplace.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-captionsplash-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-captionsplash.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-downloads-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-downloads.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-ej-dance-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-ej.dance.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-fanfave-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-fanfave.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-fashiongames-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-fashiongames.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-maids-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-maids.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-moms-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-moms.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-moviemashup-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-moviemashup.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-preview-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-preview.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-shop-mylifetime-com-1" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa-shop.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-shop-mylifetime-com-2" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "qa.shop.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}