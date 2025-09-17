variable "name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "Azure region where the Key Vault will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the Key Vault (standard or premium)."
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Number of days that soft-deleted keys and secrets are retained."
  type        = number
  default     = 90
}

variable "network_acls_bypass" {
  description = "Specifies which traffic can bypass the Key Vault firewall (e.g., AzureServices)."
  type        = string
  default     = "AzureServices"
}

variable "network_acls_default_action" {
  description = "Default action for network ACLs: Deny or Allow."
  type        = string
  default     = "Deny"
}

variable "network_acls_ip_rules" {
  description = "List of public IP addresses or ranges to allow access to the Key Vault."
  type        = list(string)
  default     = []
}

variable "network_acls_vnet_subnet_ids" {
  description = "List of subnet IDs with access to the Key Vault."
  type        = list(string)
  default     = []
}

variable "create_cmk" {
  description = "Whether to create a customer-managed key (CMK) in the Key Vault."
  type        = bool
  default     = true
}

variable "key_type" {
  description = "The type of Key Vault key to create (RSA-HSM recommended for HSM-backed)."
  type        = string
  default     = "RSA-HSM"
}

variable "key_size" {
  description = "Size of the Key Vault key in bits (e.g., 2048, 3072, 4096)."
  type        = number
  default     = 2048
}

variable "key_opts" {
  description = "List of permitted key operations."
  type        = list(string)
  default     = [
    "encrypt",
    "decrypt",
    "wrapKey",
    "unwrapKey",
    "sign",
    "verify"
  ]
}

variable "key_expiration_date" {
  description = "Expiration date for the Key Vault key in RFC3339 format (e.g., 2027-01-01T00:00:00Z)."
  type        = string
  default     = "2027-01-01T00:00:00Z"
}

variable "create_private_endpoint" {
  description = "Whether to create a private endpoint for the Key Vault."
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "The subnet ID to deploy the Key Vault private endpoint into."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the Key Vault and related resources."
  type        = map(string)
  default     = {}
}
