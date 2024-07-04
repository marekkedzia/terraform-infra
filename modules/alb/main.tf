resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb-${var.name_suffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups_ids
  subnets            = var.subnets_ids

  tags = {
    Name = "ecs-alb"
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = var.lb_config["port"]
  protocol          = var.lb_config["protocol"]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecsTargetGroup"
  port        = var.tg_config["port"]
  protocol    = var.tg_config["protocol"]
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = var.health_check_config["path"]
    port = var.health_check_config["port"]
  }
}
