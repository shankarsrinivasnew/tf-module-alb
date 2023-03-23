resource "aws_lb" "test" {
  name               = "${var.env}-${var.subnet_name}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

   tags = merge(
    var.tags,
    { Name = "${var.env}-${var.name}-alb" }
  )
}