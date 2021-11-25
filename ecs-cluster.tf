resource "aws_ecs_cluster" "my_ecs_cluster" {
    name = "ecs_cluster"

    tags = {
        Name = "ecs-cluster"
    }
}

resource "aws_ecs_task_definition" "my_task_definition" {
    family = "frontend-task-definition"
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    memory = "1024"
    cpu = "512"
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
    container_definitions = <<EOF
[
  {
    "name": "demo-container",
    "image": "639110431478.dkr.ecr.eu-west-2.amazonaws.com/frontend-image:latest",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "entryPoint": ["npm","start"],
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
EOF

}

resource "aws_ecs_service" "my_ecs_service" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.my_ecs_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }


}

