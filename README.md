## Cloud Project

### Project Overview

This project is designed to manage AWS cloud infrastructure using Terraform. It employs various modules to handle different aspects of the infrastructure, ensuring a modular and maintainable approach.

### Modules Used

- **alb**: Manages Application Load Balancers.
- **budgets**: Sets up AWS Budgets to monitor and control AWS spending.
- **cognito**: Configures Amazon Cognito for user authentication.
- **ecr**: Manages Amazon Elastic Container Registry.
- **ecs**: Configures Amazon Elastic Container Service for container orchestration.
- **iam**: Manages AWS Identity and Access Management resources.
- **lambda**: Configures AWS Lambda functions.
- **main**: Main module for central configuration.
- **mongo**: Sets up MongoDB instances.
- **s3**: Manages Amazon S3 buckets.
- **vpc**: Configures Virtual Private Cloud (VPC) resources.

### Purpose

The purpose of this project is to provide a scalable and reliable AWS infrastructure using Terraform. It leverages Terragrunt to manage remote state and apply configurations consistently across environments.

### Configuration Details

#### Local Variables

```hcl
locals {
  region = "eu-west-1"
}
```

#### Remote State Configuration

```hcl
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
```

#### Terraform Extra Arguments

```hcl
terraform {
  extra_arguments "common_vars" {
    commands  = ["plan", "apply"]
    arguments = ["-var-file=terraform-dev.tfvars", "-var=region=${local.region}"]
  }
}
```

#### Provider Configuration

```hcl
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      region = "${local.region}"
    }
    EOF
}
```

### How to Use

1. Ensure you have Terraform and Terragrunt installed.
2. Configure your AWS credentials.
3. Initialize Terragrunt:
   ```bash
   terragrunt init
   ```
4. Plan the deployment:
   ```bash
   terragrunt plan
   ```
5. Apply the configuration:
   ```bash
   terragrunt apply
   ```
