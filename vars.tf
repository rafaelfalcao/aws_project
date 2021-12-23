variable "aws-region" {
    default = "eu-west-2"
}

variable "app-prefix" {
    default = "frontend-docker"
}

variable "az_count" {
  default     = "2"
  description = "number of availability zones in above region"
}

variable "ecs_task_execution_role" {
  default     = "myECcsTaskExecutionRole"
  description = "ECS task execution role name"
}

variable "app_image" {
  default     = "nginx:latest"
  description = "docker image to run in this ECS cluster"
}

variable "github_token" {
  description = "The GitHub Token to be used for the CodePipeline"
  type        = string
}

variable "app_port" {
  default     = "8080"
  description = "portexposed on the docker image"
}

variable "app_count" {
  default     = "2" #choose 2 bcz i have choosen 2 AZ
  description = "number of docker containers to run"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  default     = "1024"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  default     = "2048"
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "container_name"{
    default = "react-app-container"
    description = "name of the container running the docker image from ecr"
}

variable "account_id" {
  description = "id of the active account"

}