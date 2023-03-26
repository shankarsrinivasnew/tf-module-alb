resource "aws_lb" "albr" {
  name               = "${var.env}-${var.name}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets

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
    cidr_blocks      = var.allow_app_to
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
