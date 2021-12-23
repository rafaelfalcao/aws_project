resource "aws_security_group" "alb-sg" {
  name   = "alb-allow-http-sg"
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

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.test-vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

