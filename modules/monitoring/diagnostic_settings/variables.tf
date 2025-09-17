variable "target_resource_id" {
  description = "The ID of the resource to attach diagnostic settings to."
  type        = string
}

variable "target_resource_name" {
  description = "Name of the target resource, used for naming the diagnostic setting."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace to send diagnostics to."
  type        = string
}

variable "log_categories" {
  description = "List of log categories to enable for the target resource."
  type        = list(string)
  default     = []
}

variable "metric_categories" {
  description = "List of metric categories to enable for the target resource."
  type        = list(string)
  default     = []
}
