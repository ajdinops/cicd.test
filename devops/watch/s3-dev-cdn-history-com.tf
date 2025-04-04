//ultraDNS
resource "ultradns_record" "cname-dev-cdn-history-com" {
  zone_name   = "history.com"
  record_type = "CNAME"
  owner_name  = "dev-cdn.history.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

module "dev-cdn-history-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "dev-cdn-history-com"
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
    target_prefix = "dev-cdn-history-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/dev-cdn-history-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "dev-cdn-history-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Public"
    "aetn:dataConsumer"          = "Fastly"
    "aetn:dataOrigin"            = "Push"
    "aetn:env"                   = "dev"
    "aetn:hostnames"             = "dev-cdn-history-com"
    "aetn:s3Template"            = "Webhosting Publishing"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "mktg"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "dev-cdn-history-com"
  }
  versioning = {
    status = true
  }
}
