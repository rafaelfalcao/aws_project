resource "aws_alb" "alb" {
  name           = "myapp-load-balancer"
  subnets        = aws_subnet.public.*.id
  security_groups = [aws_security_group.alb-sg.id]
  enable_http2    = "true"
}

resource "aws_security_group" "this" {
  name   = "allow-http"
  vpc_id = "${aws_vpc.test-vpc.id}"

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags ={
    Name = "allow-http-sg"
  }
}

resource "aws_alb" "this" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    =  ["${aws_security_group.this.id}"]
  subnets            =aws_subnet.public.*.id

  tags ={
    Name = "alb"
  }
}

locals {
  target_groups = [
    "green",
    "blue",
  ]
}

resource "aws_alb_target_group" "this" {
  count = "${length(local.target_groups)}"

  name = "example-tg-${element(local.target_groups, count.index)}"

  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.test-vpc.id}"
  target_type = "ip"

  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_alb_listener" "this" {
  load_balancer_arn = "${aws_alb.this.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.this.*.arn[0]}"
  }
}

resource "aws_alb_listener_rule" "this" {
  listener_arn = "${aws_alb_listener.this.arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.this.*.arn[0]}"
  }
  
   condition {
    host_header {
      values = ["api.example.com"]
    }
  }
}

/*
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
