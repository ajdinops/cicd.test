module "qa-emailupdates-watch-aetnd-com-s3" {
  source        = "./modules/s3/modules/s3"
  account_id    = "433624884903"
  region        = "us-east-1"
  bucket        = "qa-emailupdates-watch-aetnd-com"
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
    id = "tf-s3-lifecycle-20190404043800523800000001"
    noncurrent_version_transition = [{
      noncurrent_days = 7
      storage_class   = "GLACIER"
      storage_classs  = false
    }]
  }]
  logging = {
    target_bucket = "logs-s3-433624884903-us-east-1"
    target_prefix = "qa-emailupdates-watch-aetnd-com/"
  }
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
  request_payer            = "BucketOwner"
  attach_policies          = true
  bucket_policies          = file("./policies/qa-emailupdates-watch-aetnd-com.yaml")
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Environment                  = "Prod"
    Name                         = "qa-emailupdates-watch-aetnd-com"
    "Application ID"             = "AWS"
    Role                         = "infra"
    "aetn:dataClassification"    = "Restricted"
    "aetn:dataConsumer"          = "Console"
    "aetn:dataOrigin"            = "Vendor"
    "aetn:env"                   = "qa"
    "aetn:hostnames"             = "qa-emailupdates-watch-aetnd-com"
    "aetn:s3Template"            = "Restricted-Bucket"
    "Line of Business - Primary" = "digital"
    env                          = "qa"
    Environment                  = "qa"
    group                        = "watch"
    Security                     = "internal"
    Automation                   = "terraform"
    hostnames                    = "qa-emailupdates-watch-aetnd-com"
  }
  versioning = {
    status = true
  }
}
