resource "aws_ecr_repository" "ecr_repo" {
    name  = "frontend-image"
}

resource "aws_ecr_repository_policy" "repo-policy" {
  repository = aws_ecr_repository.my_ecr_repo.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}

##  Build Docker image and push to ECR
resource "docker_registry_image" "frontend" {
  name = "${aws_ecr_repository.ecr-repo.repository_url}:latest"

  build { 
    context = "../weather-app-indicator"
    dockerfile = "Dockerfile"
  }  
}

