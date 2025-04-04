# The following variable is used to configure the provider's authentication
# token. You don't need to provide a token on the command line to apply changes,
# though: using the remote backend, Terraform will execute remotely in Terraform
# Cloud where your token is already securely stored in your workspace!

provider "tfe" {
  token = local.root_outputs.tfe_token
}

provider "aws" {
  region     = "us-east-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "ap-northeast-1"
  region     = "ap-northeast-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "ap-northeast-2"
  region     = "ap-northeast-2"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "ap-northeast-3"
  region     = "ap-northeast-3"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "ap-south-1"
  region     = "ap-south-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "ap-southeast-1"
  region     = "ap-southeast-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "ap-southeast-2"
  region     = "ap-southeast-2"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "ca-central-1"
  region     = "ca-central-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "eu-central-1"
  region     = "eu-central-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "eu-north-1"
  region     = "eu-north-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "eu-west-1"
  region     = "eu-west-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "eu-west-2"
  region     = "eu-west-2"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "eu-west-3"
  region     = "eu-west-3"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "sa-east-1"
  region     = "sa-east-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "us-east-1"
  region     = "us-east-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "us-east-2"
  region     = "us-east-2"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "us-west-1"
  region     = "us-west-1"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "aws" {
  alias      = "us-west-2"
  region     = "us-west-2"
  access_key = local.root_outputs["aws_access_key_id_aetv"]
  secret_key = local.root_outputs["aws_secret_id_aetv"]
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/terraform-cloud-role"
  }
}

provider "datadog" {
  api_key = local.root_outputs["datadog_api_key_secret"]
  app_key = local.root_outputs["datadog_app_key_secret"]
  api_url = var.datadog_api_url
}

provider "fastly" {
  api_key = local.root_outputs["fastly_api_token"]
}

provider "pagerduty" {
  token = local.root_outputs["pagerduty_api_token"]
}

provider "sigsci" {
  corp           = "a_n_e"
  email          = local.root_outputs["sigsci_email"]
  auth_token     = local.root_outputs["sigsci_token"]
  fastly_api_key = local.root_outputs["fastly_api_token"]
}

provider "ultradns" {
  username = local.root_outputs["ultradns_username"]
  password = local.root_outputs["ultradns_password"]
  hosturl  = "https://api.ultradns.com/"
}
