resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "logs" {
  name = "/ecs/fargate-${var.name_suffix}"
}

resource "aws_cloudwatch_log_stream" "logs_stream" {
  log_group_name = aws_cloudwatch_log_group.logs.name
  name           = "ecs/fargate-${var.name_suffix}"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "ecs-task-${var.name_suffix}"
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecs_instance_role_arn
  task_role_arn            = var.ecs_iam_task_role
  cpu                      = var.ecs_resources_config.cpu
  memory                   = var.ecs_resources_config.memory
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name         = "dockergs",
      image        = var.ecs_task_image,
      cpu          = var.ecs_resources_config.cpu,
      memory       = var.ecs_resources_config.memory,
      essential    = true,
      environment  = var.custom_environment_variables,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-region"        = var.region
          "awslogs-group"         = aws_cloudwatch_log_group.logs.name
          "awslogs-stream-prefix" = "ecs/fargate-${var.name_suffix}"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service-${var.name_suffix}"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.capacity.desired
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets_ids
    security_groups  = var.security_groups_ids
    assign_public_ip = true
  }

  force_new_deployment = true

  load_balancer {
    target_group_arn = var.ecs_tg_arn
    container_name   = "dockergs"
    container_port   = 80
  }
}

