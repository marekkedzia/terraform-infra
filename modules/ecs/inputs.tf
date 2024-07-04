variable "name_suffix" {
  description = "A suffix to append to the name of the resources"
  type        = string
}

variable "region" {
  description = "The region in which the resources will be created"
  type        = string
}

variable "security_groups_ids" {
  description = "The IDs of the security groups to attach to the instance"
  type        = list(string)
}

variable "subnets_ids" {
  description = "The IDs of the subnets to attach to the instance"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "capacity" {
  description = "The object that describes count of instances to launch"
  type        = object({
    desired = number
  })
  default = {
    desired = 1
  }
}

variable "ecs_instance_role_arn" {
  description = "The ARN of the IAM role that the ECS container agent and the Docker daemon can assume"
  type        = string
}

variable "ecs_iam_task_role" {
  description = "The ARN of the IAM role that the ECS container agent and the Docker daemon can assume"
  type        = string
}

variable "ecs_task_image" {
  description = "The image to use for the ECS task"
  type        = string
}

variable "ecs_resources_config" {
  description = "The object that describes the resources configuration for the ECS task"
  type        = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 256
    memory = 512
  }
}

variable "ecs_tg_arn" {
  description = "The ARN of the target group to attach to the ECS service"
  type        = string
}

variable "custom_environment_variables" {
  description = "Custom environment variables to pass to the ECS task {[name:string]:string}"
  type        = list(object(
    {
      name  = string
      value = string
    }
  ))
}
