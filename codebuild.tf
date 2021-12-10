resource "aws_codebuild_project" "this" {
  name         = "codebuild"
  description  = "Codebuild for the ECS Green/Blue Example app"
  service_role = "${aws_iam_role.codebuild.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/docker:18.09.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name = "REPOSITORY_URI"
      value = "${aws_ecr_repository.ecr_repo.repository_url}"
    }
  }
  source {
    type = "CODEPIPELINE"
  }
}

resource "aws_codepipeline" "this" {
  name     = "cicd-pipeline"
  role_arn = "${aws_iam_role.pipeline.arn}"

  artifact_store {
    location = "${aws_s3_bucket.codepipeline-artifacts.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        OAuthToken = "${var.github_token}"
        Owner      = "snowiow"
        Repo       = "green-blue-ecs-example"
        Branch     = "master"
      }
    }
  }

  stage {
  name = "Build"

  action {
    name             = "Build"
    category         = "Build"
    owner            = "AWS"
    provider         = "CodeBuild"
    version          = "1"
    input_artifacts  = ["source"]
    output_artifacts = ["build"]

    configuration ={
      ProjectName = "react_app"
    }
    }
  }

}