variable "vpc_cidr_block" {
  description = "CIDR alocation for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_pub_cidr_block_1" {
  description = "CIDR alocation for public subnet"
  type        = string
  default     = "10.0.200.0/22"
}

variable "subnet_pub_cidr_block_2" {
  description = "CIDR alocation for public subnet"
  type        = string
  default     = "10.0.208.0/22"
}

variable "map_public_ips" {
  description = "Map public IP on instances"
  type        = bool
  default     = true
}

