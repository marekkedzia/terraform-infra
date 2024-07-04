terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
}

locals {
  db_user            = "db-user-${var.name_suffix}"
  mongo_cluster_name = "mongo-cluster-${var.name_suffix}"
  mongo_db_name      = "db-${var.name_suffix}"
}

data "mongodbatlas_roles_org_id" "org" {}

resource "mongodbatlas_project" "project" {
  name   = "mongo-project-${var.name_suffix}"
  org_id = data.mongodbatlas_roles_org_id.org.id
}

resource "mongodbatlas_cluster" "cluster" {
  project_id                  = mongodbatlas_project.project.id
  name                        = local.mongo_cluster_name
  cluster_type                = null
  backing_provider_name       = var.provider_name
  provider_region_name        = var.region_name
  provider_name               = "TENANT"
  mongo_db_major_version      = "7.0"
  provider_instance_size_name = var.instance_size_name

  dynamic "replication_specs" {
    for_each = []
    content {
      num_shards = 1
      regions_config {
        region_name     = var.provider_name
        electable_nodes = 3
        priority        = 7
        read_only_nodes = 0
      }
    }
  }
}

resource "mongodbatlas_project_ip_access_list" "ip_access_list" {
  for_each   = toset(var.ip_access_list)
  project_id = mongodbatlas_project.project.id
  ip_address = each.value
}

resource "random_password" "mongo_password" {
  length  = 30
  special = false
  keepers = {
    def : "password-${var.name_suffix}"
  }
}

resource "mongodbatlas_database_user" "user" {
  username           = local.db_user
  password           = random_password.mongo_password.result
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"

  scopes {
    name = local.mongo_cluster_name
    type = "CLUSTER"
  }

  roles {
    role_name     = "readWrite"
    database_name = local.mongo_db_name
  }

  labels {
    key   = "created_by"
    value = "terraform"
  }

  labels {
    key   = "db"
    value = local.mongo_db_name
  }
}
