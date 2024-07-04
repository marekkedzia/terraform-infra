output "mongo_server_url" {
  value = "mongodb+srv://${local.db_user}:${mongodbatlas_database_user.user.password}@${split("mongodb+srv://", mongodbatlas_cluster.cluster.connection_strings[0].standard_srv)[1]}/${local.mongo_db_name}?retryWrites=true&w=majority"
}

output "db_name" {
    value = local.mongo_db_name
}
