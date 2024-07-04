variable "role_name" {
  description = "Role name"
  type        = string
  default     = null
}

variable "service" {
  description = "Service"
  type        = string
  default     = null
}

variable "statements" {
  description = "List of statements for the role"
  type        = list(object({ actions = list(string), resources = list(string) }))
  default     = null
}
