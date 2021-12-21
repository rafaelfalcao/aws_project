resource "aws_codedeploy_deployment_group" "this" {
  app_name               = "${aws_codedeploy_app.this.name}"
  deployment_group_name  = "codedeploy-group"
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  service_role_arn       = "${aws_iam_role.codedeploy.arn}"

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
    }
  }

  ecs_service {
    cluster_name = "${aws_ecs_cluster.my_ecs_cluster.name}"
    service_name = "${aws_ecs_service.my_ecs_service.name}"
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = ["${aws_alb_listener.this.arn}"]
      }

      target_group {
        name = "${aws_alb_target_group.this.*.name[0]}"
      }

      target_group {
        name = "${aws_alb_target_group.this.*.name[1]}"
      }
    }
  }
}


resource "aws_codedeploy_app" "this" {
  compute_platform = "ECS"
  name             = "example-deploy"
}
