# -----------------------------------------------------------------------------
# Provider - default
# -----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.84.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3.53.0"
    }
    fastly = {
      source  = "fastly/fastly"
      version = ">= 5.15.0"
    }
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 3.19.2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.63.0, < 1.0.0"
    }
    sigsci = {
      source  = "signalsciences/sigsci"
      version = ">= 3.4.0"
    }
    ultradns = {
      source  = "ultradns/ultradns"
      version = ">= 1.11.0"
    }
  }

  backend "remote" {
    organization = "AETN"
    workspaces {
      name = "aetnd-prod-va-watch"
    }
  }
}
