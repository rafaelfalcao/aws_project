resource "aws_iam_role" "codedeploy" {
  name               = "codedeploy"
  assume_role_policy = "${data.aws_iam_policy_document.codedeploy.json}"
}

data "aws_iam_policy_document" "codedeploy" {
  statement {
    sid    = "AllowLoadBalancingAndECSModifications"
    effect = "Allow"

    actions = [
      "ecs:CreateTaskSet",
      "ecs:DeleteTaskSet",
      "ecs:DescribeServices",
      "ecs:UpdateServicePrimaryTaskSet",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyRule",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowS3"
    effect = "Allow"

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.codepipeline-artifacts.arn}/*"]
  }

  statement {
    sid    = "AllowPassRole"
    effect = "Allow"

    actions = ["iam:PassRole"]

    resources = [
      "${aws_iam_role.ecs_task_execution_role.arn}"
    ]
  }
}

resource "aws_iam_role_policy" "codedeploy" {
  role   = "${aws_iam_role.codedeploy.name}"
  policy = "${data.aws_iam_policy_document.codedeploy.json}"
}