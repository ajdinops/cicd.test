module "prod-editorials-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "prod-editorials-watch-aetnd-com"
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
    target_prefix = "prod-editorials-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/prod-editorials-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "prod-editorials-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Public"
    "aetn:dataConsumer"          = "Fastly"
    "aetn:dataOrigin"            = "EC2"
    "aetn:env"                   = "prod"
    "aetn:hostnames"             = "prod-editorials-watch-aetnd-com"
    "aetn:s3Template"            = "Webhosting Publishing"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "prod-editorials-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//ultraDNs
resource "ultradns_rdpool" "a-4unitedvoices-com" {
  zone_name   = "4unitedvoices.com"
  record_type = "A"
  owner_name  = "4unitedvoices.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-4unitedvoices-com" {
  zone_name   = "4unitedvoices.com"
  record_type = "AAAA"
  owner_name  = "4unitedvoices.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-4unitedvoices-com" {
  zone_name   = "4unitedvoices.com"
  record_type = "CNAME"
  owner_name  = "www.4unitedvoices.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-4uv-com" {
  zone_name   = "4uv.com"
  record_type = "A"
  owner_name  = "4uv.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-4uv-com" {
  zone_name   = "4uv.com"
  record_type = "AAAA"
  owner_name  = "4uv.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-4uv-com" {
  zone_name   = "4uv.com"
  record_type = "CNAME"
  owner_name  = "www.4uv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-livelyplace-com" {
  zone_name   = "livelyplace.com"
  record_type = "A"
  owner_name  = "livelyplace.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-livelyplace-com" {
  zone_name   = "livelyplace.com"
  record_type = "AAAA"
  owner_name  = "livelyplace.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-www-livelyplace-com" {
  zone_name   = "livelyplace.com"
  record_type = "CNAME"
  owner_name  = "www.livelyplace.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_rdpool" "a-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "A"
  owner_name  = "mylifetime.com."
  record_data = [
    "151.101.2.168",
    "151.101.66.168",
    "151.101.130.168",
    "151.101.194.168",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_rdpool" "aaaa-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "AAAA"
  owner_name  = "mylifetime.com."
  record_data = [
    "2a04:4e42:0:0:0:0:0:680",
    "2a04:4e42:200:0:0:0:0:680",
    "2a04:4e42:400:0:0:0:0:680",
    "2a04:4e42:600:0:0:0:0:680",
  ]
  ttl   = 300
  order = "ROUND_ROBIN"
}

resource "ultradns_record" "cname-captionsplash-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "captionsplash.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-downloads-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "downloads.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-ej-dance-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "ej.dance.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-fanfave-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "fanfave.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-fashiongames-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "fashiongames.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-maids-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "maids.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-moms-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "moms.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-moviemashup-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "moviemashup.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-preview-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "preview.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-shop-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "shop.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "www.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-www-shop-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "www.shop.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}