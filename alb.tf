resource "aws_alb" "alb" {
  name           = "myapp-load-balancer"
  subnets        = aws_subnet.public.*.id
  security_groups = [aws_security_group.alb-sg.id]
}

resource "aws_alb_target_group" "frontend-ecs-tg" {
  name        = "frontend-ecs-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.test-vpc.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path
    interval            = 30
  }
}

#redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "http-listener" {
  load_balancer_arn = aws_alb.alb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.frontend-ecs-tg.arn
  }
}

/*

resource "aws_acm_certificate" "ssl-https-listener-certificate" {
  domain_name = "myapp-load-balancer-672630631.eu-west-2.elb.amazonaws.com"
  validation_method = "DNS"  
}

resource "aws_alb_listener_certificate" "example" {
  listener_arn    = aws_alb_listener.https-listener.arn
  certificate_arn = aws_acm_certificate.ssl-https-listener-certificate.arn
}


resource "aws_alb_listener" "https-listener" {
  load_balancer_arn = aws_alb.alb.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ssl-https-listener-certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.frontend-ecs-tg.arn
  }
}

resource "aws_alb_listener" "http-to-http-redirect" {
  load_balancer_arn = aws_alb.alb.id
  port              = 443
  protocol          = "HTTPS"

  default_action {
    type             = "redirect"
  
    redirect{
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
*/ 
