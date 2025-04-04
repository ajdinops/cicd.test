module "s3-aetv-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "s3.aetv.com"
  force_destroy = true
  owner = {
    display_name = "devops"
  }
  lifecycle_rule = [{
    enabled = true
    filter = {
      prefix = ""
    }
    id = "tf-s3-lifecycle-20180702102430988700000006"
    noncurrent_version_transition = [{
      noncurrent_days = 7
      storage_class   = "GLACIER"
      storage_classs  = false
    }]
  }]
  logging = {
    target_bucket = "logs-s3-433624884903-us-east-1"
    target_prefix = "s3.aetv.com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/s3-aetv-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "s3.aetv.com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataConsumer"          = "fastly"
    "aetn:dataOrigin"            = "EC2"
    "aetn:env"                   = "prod"
    "aetn:hostnames"             = "s3.aetv.com"
    "aetn:s3securitytemplate"    = "webhosting-publishing-cf"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "mktg"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "s3.aetv.com"
  }
  versioning = {
    status = true
  }
}

//UltrDNS Records
resource "ultradns_record" "cname-s3-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "s3.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-dev-s3-aetv-com" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "dev-s3.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-s3-aetv-com-1" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa-s3.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}

resource "ultradns_record" "cname-qa-s3-aetv-com-2" {
  zone_name   = "aetv.com"
  record_type = "CNAME"
  owner_name  = "qa.s3.aetv.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}