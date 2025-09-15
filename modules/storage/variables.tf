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
  default     = "GRS"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "enable_private_endpoint" {
  type    = bool
  default = false
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for private endpoint"
  default     = null
}

variable "customer_managed_key_id" {
  type        = string
  description = "ID of the customer-managed key (Key Vault)"
  default     = null
}

variable "key_vault_id" {
  type        = string
  default     = null
}

variable "customer_managed_key_name" {
  type    = string
  default = null
}

variable "customer_managed_key_version" {
  type    = string
  default = null
}


