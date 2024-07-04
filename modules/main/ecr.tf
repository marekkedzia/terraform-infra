module "ecr" {
  source          = "../ecr"
  repository_name = "ecr-${var.project}-${var.environment}"
}
