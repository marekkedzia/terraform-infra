module "mongo" {
  source             = "../mongo"
  name_suffix        = "${var.project}-${var.environment}"
  instance_size_name = var.mongo_instance_size_name
  region_name        = var.mongo_aws_region
  ip_access_list     = var.mongo_cluster_ip_whitelist
  provider_name      = var.mongo_cloud_provider_name
}
