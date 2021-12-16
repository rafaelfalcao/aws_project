resource "aws_ecr_repository" "ecr_repo" {
    name  = "frontend-image"
}

##  Build Docker image and push to ECR

#Reads the image metadata from a Docker Registry. Used in conjunction with the docker_image resource to keep an image up to date on the latest available version of the tag.
resource "docker_registry_image" "frontend" {
  name = "${aws_ecr_repository.ecr_repo.repository_url}:latest"

  build { 
    context = "weather-app-indicator"
    dockerfile = "Dockerfile"
  }  
}

 