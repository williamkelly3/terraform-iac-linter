variable "name" {
  description = "Base name for monitoring resources."
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "workspace_sku" {
  description = "SKU for Log Analytics Workspace (PerGB2018, Free, etc.)."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Retention period for logs (default 30 days)."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to monitoring resources."
  type        = map(string)
  default     = {}
}
