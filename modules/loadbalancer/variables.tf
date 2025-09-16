variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "is_public" {
  description = "Whether this is a public load balancer (true) or internal (false)"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "Subnet ID for internal LB (required if is_public = false)"
  type        = string
  default     = null
}

variable "probe_port" {
  description = "Port for health probe"
  type        = number
  default     = 80
}

variable "frontend_port" {
  description = "Frontend port exposed by the load balancer"
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "Port that backend pool will receive traffic on"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
