provider "aws" {
    region = "${var.aws-region}"
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

## Setup Docker provider and proper credentials to push to ECR
provider "docker" {
    registry_auth {
        address = local.aws_ecr_url
        username = data.aws_ecr_authorization_token.dockertoken.user_name
        password = data.aws_ecr_authorization_token.dockertoken.password
    }
}