/* resource "aws_alb" "dev-alb" {
  name               = "dev-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.SUBNETS_IDS
  security_groups    = [aws_security_group.example-alb-securitygroup.id]

  tags = {
    Name = "example-saas-production-alb"
  }
}

resource "aws_alb_target_group" "example-production-tg" {
  name     = "example-production-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.VPC_ID
}

resource "aws_alb_listener" "nginx-listeners" {
  load_balancer_arn = aws_alb.example-production-alb.arn
  port              = "80"
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.example-production-tg.arn
  }
} */