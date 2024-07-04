module "alb" {
  source              = "../alb"
  name_suffix         = "${var.project}-${var.environment}"
  subnets_ids         = module.vpc.subnet_public_ids
  security_groups_ids = [module.vpc.security_group_id]
  vpc_id              = module.vpc.vpc_id
}
