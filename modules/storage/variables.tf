variable "name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to."
  type        = string
}

variable "account_tier" {
  description = "The storage account tier (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "The replication type (LRS, GRS, etc)."
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
