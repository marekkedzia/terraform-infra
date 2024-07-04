variable "name_suffix" {
  description = "Suffix to add to the name of the resources"
  type        = string
}

variable "subnets_ids" {
  description = "List of Subnet IDs"
  type        = list(string)
}

variable "security_groups_ids" {
  description = "List of Security Group IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "tg_config" {
  description = "Target Group Configuration"
  type        = object({
    protocol = string
    port     = number
  })
  default = {
    protocol = "HTTP"
    port     = 80
  }
}

variable "lb_config" {
  description = "Load Balancer Configuration"
  type        = object({
    protocol = string
    port     = number
  })
  default = {
    protocol = "HTTP"
    port     = 80
  }
}

variable "health_check_config" {
  description = "Health Check Configuration"
  type        = object({
    port = number
    path = string
  })
  default = {
    port = 80
    path = "/"
  }
}
