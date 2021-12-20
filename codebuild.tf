resource "aws_codebuild_project" "this" {
  name         = "codebuild"
  description  = "Codebuild for the ECS Green/Blue"
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

    environment_variable {
      name  = "TASK_DEFINITION"
      value = "arn:aws:ecs:${var.aws-region}:${var.account_id}:task-definition/${aws_ecs_task_definition.my_task_definition.family}"
    }

    environment_variable {
      name  = "CONTAINER_NAME"
      value = "${aws_s3_bucket.codepipeline-artifacts.id}"
    }

    environment_variable {
      name  = "SUBNET_1"
      value = "${aws_subnet.public.*.id[0]}"
    }

    environment_variable {
      name  = "SUBNET_2"
      value = "${aws_subnet.public.*.id[1]}"
    }

    environment_variable {
      name  = "SECURITY_GROUP"
      value = "${aws_security_group.ecs_sg.id}"
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}