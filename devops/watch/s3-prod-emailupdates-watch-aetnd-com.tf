module "prod-emailupdates-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "prod-emailupdates-watch-aetnd-com"
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
    allowed_headers = ["*"]
    allowed_methods = ["DELETE", "GET", "HEAD", "POST", "PUT"]
    allowed_origins = ["https://filebox.aenetworks.com"]
    expose_headers  = ["ETag"]
    id              = ""
    max_age_seconds = 0
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
    target_prefix = "prod-emailupdates-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/prod-emailupdates-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "prod-emailupdates-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Restricted"
    "aetn:dataConsumer"          = "Console"
    "aetn:dataOrigin"            = "Vendor"
    "aetn:env"                   = "prod"
    "aetn:hostnames"             = "prod-emailupdates-watch-aetnd-com"
    "aetn:s3Template"            = "Restricted-Bucket"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "prod-emailupdates-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//UltraDNS
resource "ultradns_record" "cname-emailupdates-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "emailupdates.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-emailupdates-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "emailupdates.history.com."
  record_data = [
    "emailupdates.history.com.edgesuite.net.",
  ]
  ttl = 86400
}
