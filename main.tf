resource "aws_lb" "albr" {
  name               = "${var.env}-${var.name}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets
  security_groups    = [aws_security_group.sgr.id]

  enable_deletion_protection = var.enable_deletion_protection

   tags = merge(
    var.tags,
    { Name = "${var.env}-${var.name}-alb" }
  )
}

resource "aws_security_group" "sgr" {
  name        = "${var.name}-${var.env}-sg"
  description = "${var.name}-${var.env}-sg"
  vpc_id      = var.vpc_id

  ingress {
    description      = "for external traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.allow_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
      var.tags,
      { Name = "${var.name}-${var.env}" }
    )
}

resource "aws_lb_listener" "listenerr" {
  load_balancer_arn = aws_lb.albr
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>503 - Invalid Request.Use r53 dns name </h1>"
      status_code  = "503"
    }
  }
}