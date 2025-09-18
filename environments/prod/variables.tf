variable "location" {
  description = "The Azure region to deploy to."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-prod-resources"
}

variable "ssh_public_key" {
  description = "SSH public key for VMSS admin access."
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default = {
    environment = "prod"
    owner       = "w.kelly"
  }
}
