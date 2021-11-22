data "aws_caller_identity" "currentuser" {
    //Use this data source to get the access to the effective Account ID, User ID, and ARN in which Terraform is authorized.
}

data "aws_ecr_authorization_token" "dockertoken" {
    //The ECR Authorization Token data source allows the authorization token, proxy endpoint, token expiration date, user name and password to be retrieved for an ECR repository.
}