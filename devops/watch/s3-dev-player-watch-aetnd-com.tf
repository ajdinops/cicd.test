module "dev-player-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "dev-player-watch-aetnd-com"
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
    target_prefix = "dev-player-watch-aetnd-com/"
  }
  request_payer   = "BucketOwner"
  attach_policies = true
  bucket_policies = file("./policies/dev-player-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name                         = "dev-player-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Public"
    "aetn:dataConsumer"          = "Fastly"
    "aetn:dataOrigin"            = "EC2"
    "aetn:env"                   = "dev"
    "aetn:hostnames"             = "dev-player-watch-aetnd-com"
    "aetn:s3Template"            = "Webhosting Publishing"
    "Line of Business - Primary" = "digital"
    env                          = "dev"
    Environment                  = "dev"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "dev-player-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}
