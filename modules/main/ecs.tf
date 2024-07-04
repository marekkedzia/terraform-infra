module "iam_role_backend_service" {
  source     = "../iam"
  statements = [
    {
      actions : [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      resources : [
        "${module.files.bucket_arn}/*"
      ]
    },
    {
      actions : [
        "s3:ListBucket",
      ],
      resources : [
        module.files.bucket_arn,
      ]
    },

  ]
  role_name = "backend-service-task-role-${var.environment}"
  service   = "ecs-tasks.amazonaws.com"
}

data "aws_iam_policy_document" "assume_role_ecs" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs-task-execution-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_ecs.json
}

module "ecs" {
  source                       = "../ecs"
  name_suffix                  = "${var.project}_${var.environment}"
  security_groups_ids          = [module.vpc.security_group_id]
  subnets_ids                  = module.vpc.subnet_public_ids
  cluster_name                 = "ecs_cluster_${var.project}_${var.environment}"
  ecs_instance_role_arn        = aws_iam_role.ecs_task_execution_role.arn
  ecs_iam_task_role            = module.iam_role_backend_service.role_arn
  ecs_task_image               = module.ecr.task_image
  ecs_tg_arn                   = module.alb.ecs_tg_arn
  region                       = var.region
  custom_environment_variables = [
    {
      name  = "MONGO_URL"
      value = module.mongo.mongo_server_url
    },
    {
      name  = "AWS_REGION"
      value = var.region
    },
    {
      name  = "S3_BUCKET_NAME"
      value = module.files.bucket_name
    },
    {
      name  = "FREE_PLAN_STORAGE_IN_KB"
      value = var.free_plan_storage_in_kb
    },
    {
      name  = "PREMIUM_PLAN_STORAGE_IN_KB"
      value = var.premium_plan_storage_in_kb
    },
    {
      name  = "COGNITO_CLIENT_ID"
      value = module.cognito.user_pool_client_id
    },
    {
      name  = "COGNITO_USER_POOL_ID"
      value = module.cognito.user_pool_id
    },
    {
      name  = "COGNITO_USER_PASSWORD_MINIMUM_LENGTH"
      value = var.cognito_user_password_minimum_length
    },
  ]
}
