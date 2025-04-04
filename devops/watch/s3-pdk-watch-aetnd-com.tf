module "pdk-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "pdk-watch-aetnd-com"
  force_destroy = true
  owner = {
    display_name = "devops"
  }
  cors_rule = [{
    allowed_headers = ["*"]
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
    id = "tf-s3-lifecycle-20180614124633180700000002"
    noncurrent_version_transition = [{
      noncurrent_days = 7
      storage_class   = "GLACIER"
      storage_classs  = false
    }]
  }]
  logging = {
    target_bucket = "logs-s3-433624884903-us-east-1"
    target_prefix = "pdk-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/pdk-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "pdk-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataConsumer"          = "fastly"
    "aetn:dataOrigin"            = "EC2"
    "aetn:env"                   = "prod"
    "aetn:hostnames"             = "pdk-watch-aetnd-com"
    "aetn:s3securitytemplate"    = "webhosting-publishing-cors-cf"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "pdk-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}

//ultraDNS
resource "ultradns_record" "cname-pdk-watch-aetnd-com" {
  zone_name   = "aetnd.com"
  record_type = "CNAME"
  owner_name  = "pdk.watch.aetnd.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}