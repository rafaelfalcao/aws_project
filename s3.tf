resource "aws_s3_bucket" "codepipeline-artifacts" {
    bucket = "pipeline-artifacts-rf"
    acl = "private"
    
    tags = {
      "Name" = "pipeline-artifacts-bucket"
    }
}