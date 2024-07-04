locals {
  region = "eu-west-1"
}

remote_state {
  backend  = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "ikaros-dev-state"
    key    = "terraform.tfstate"
    region = local.region
  }
}

terraform {
  extra_arguments "common_vars" {
    commands  = ["plan", "apply"]
    arguments = ["-var-file=terraform-dev.tfvars", "-var=region=${local.region}"]
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
    region = "${local.region}"
    }
    EOF
}
