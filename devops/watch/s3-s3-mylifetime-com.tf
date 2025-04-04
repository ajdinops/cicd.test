module "s3-mylifetime-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "s3.mylifetime.com"
  force_destroy = true
  owner = {
    display_name = "devops"
  }
  lifecycle_rule = [{
    enabled = true
    filter = {
      prefix = ""
    }
    id = "tf-s3-lifecycle-20180702102432219400000009"
    noncurrent_version_transition = [{
      noncurrent_days = 7
      storage_class   = "GLACIER"
      storage_classs  = false
    }]
  }]
  logging = {
    target_bucket = "logs-s3-433624884903-us-east-1"
    target_prefix = "s3.mylifetime.com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/s3-mylifetime-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "s3.mylifetime.com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataConsumer"          = "fastly"
    "aetn:dataOrigin"            = "EC2"
    "aetn:env"                   = "prod"
    "aetn:hostnames"             = "s3.mylifetime.com"
    "aetn:s3securitytemplate"    = "webhosting-publishing-cf"
    "Line of Business - Primary" = "digital"
    env                          = "prod"
    Environment                  = "prod"
    group                        = "mktg"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "s3.mylifetime.com"
  }
  versioning = {
    status = true
  }
}

//ultraDNS
resource "ultradns_record" "cname-s3-mylifetime-com" {
  zone_name   = "mylifetime.com"
  record_type = "CNAME"
  owner_name  = "s3.mylifetime.com."
  record_data = [
    "http2.aenet.map.fastly.net.",
  ]
  ttl = 86400
}
