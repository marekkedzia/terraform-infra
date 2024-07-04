variable "name_suffix" {
  description = "The suffix to append to the name of the cluster"
  type        = string
}

variable "instance_size_name" {
  description = "The name of the instance size"
  type        = string
}

variable "region_name" {
  description = "The name of the region"
  type        = string
}

variable "ip_access_list" {
  description = "The list of IP addresses that can access the cluster"
  type        = list(string)
}

variable "provider_name" {
  description = "The name of the provider"
  type        = string
}
