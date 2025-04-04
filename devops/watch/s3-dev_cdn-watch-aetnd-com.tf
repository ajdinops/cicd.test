module "dev_cdn-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "dev.cdn.watch.aetnd.com"
  force_destroy = true
  owner = {
    display_name = "devops"
  }
  cors_rule = [{
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["http://dev-opw.mylifetime.com"]
    expose_headers  = []
    id              = ""
    max_age_seconds = 3000
  }]
  lifecycle_rule = [{
    enabled = true
    filter = {
      prefix = ""
    }
    id = "tf-s3-lifecycle-2018061412472367210000000a"
    noncurrent_version_transition = [{
      noncurrent_days = 7
      storage_class   = "GLACIER"
      storage_classs  = false
    }]
  }]
  logging = {
    target_bucket = "logs-s3-433624884903-us-east-1"
    target_prefix = "dev.cdn.watch.aetnd.com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/dev_cdn-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "dev.cdn.watch.aetnd.com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataConsumer"          = "fastly"
    "aetn:dataOrigin"            = "EC2"
    "aetn:env"                   = "dev"
    "aetn:hostnames"             = "dev.cdn.watch.aetnd.com"
    "aetn:s3securitytemplate"    = "webhosting-publishing-cors-cf"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "dev.cdn.watch.aetnd.com"
  }
  versioning = {
    status = true
  }
}
