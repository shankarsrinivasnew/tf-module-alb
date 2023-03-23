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