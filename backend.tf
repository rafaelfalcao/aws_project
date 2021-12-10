/*resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-state-file-repo-rf"
}


terraform {
  backend "s3" {
    bucket = "terraform-state-file-repo-rf"
    key = "terraform.tfstate"
    region = "eu-west-2"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
*/