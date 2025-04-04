data "terraform_remote_state" "root" {
  backend = "remote"
  config = {
    organization = "AETN"
    workspaces = {
      name = "root"
    }
  }
}

locals {
  root_outputs = data.terraform_remote_state.root.outputs
}
