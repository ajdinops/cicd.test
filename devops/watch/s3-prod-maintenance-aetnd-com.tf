module "prod-maintenance-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "prod-maintenance-aetnd-com"
  force_destroy = true
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
    id = "tf-s3-lifecycle-20180529171520498100000001"
    noncurrent_version_transition = [{
      noncurrent_days = 7
      storage_class   = "GLACIER"
      storage_classs  = false
    }]
  }]
  logging = {
    target_bucket = "logs-s3-433624884903-us-east-1"
    target_prefix = "prod-maintenance-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/prod-maintenance-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "prod-maintenance-aetnd-com"
    "aetn:env"                   = "prod"
    "aetn:hostnames"             = "prod-maintenance-aetnd-com"
    "aetn:s3securitytemplate"    = "maintenance"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "mktg"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "prod-maintenance-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//UltraDNS
resource "ultradns_record" "cname-maintenance-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "maintenance.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-maintenance-crimeandinvestigationnetwork-com" {
  zone_name   = "crimeandinvestigationnetwork.com"
  record_type = "CNAME"
  owner_name  = "maintenance.crimeandinvestigationnetwork.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-maintenance-fyi-tv" {
  zone_name   = "fyi.tv"
  record_type = "CNAME"
  owner_name  = "maintenance.fyi.tv."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-maintenance-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "maintenance.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-maintenance-historyvault-com" {
  zone_name   = "historyvault.com"
  record_type = "CNAME"
  owner_name  = "maintenance.historyvault.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-maintenance-lifetimemovieclub-com" {
  zone_name   = "lifetimemovieclub.com"
  record_type = "CNAME"
  owner_name  = "maintenance.lifetimemovieclub.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-maintenance-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "maintenance.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}