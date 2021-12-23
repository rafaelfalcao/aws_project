
resource "aws_codepipeline" "aws-codepipeline" {
  name     = "blue-green-pipeline"
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
        Owner      = "rafaelfalcao"
        Repo       = "aws_project"
        Branch     = "main"
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

      configuration = {
        ProjectName = "${aws_codebuild_project.codebuild-project.name}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      version         = "1"
      input_artifacts = ["build"]

      configuration = {
        ApplicationName                = "${aws_codedeploy_app.codedeploy-app.name}"
        DeploymentGroupName            = "${aws_codedeploy_deployment_group.codedeploy-deployment-group.deployment_group_name}"
        TaskDefinitionTemplateArtifact = "build"
        AppSpecTemplateArtifact        = "build"
      }
    }
  }
}