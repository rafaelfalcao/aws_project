provider "aws" {
    region = "${var.AWS_REGION}"
}


## Setup Docker provider and proper credentials to push to ECR
provider "docker" {
    registry_auth {
        address = local.aws_ecr_url
        username = data.aws_ecr_authorization_token.dockertoken.username
        password = data.aws_ecr_authorization_token.dockertoken.password
    }
  
}