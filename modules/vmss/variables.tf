variable "name" {
  description = "Name of the VM scale set"
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

variable "subnet_id" {
  description = "Subnet ID where the VMSS will deploy"
  type        = string
}

variable "backend_pool_id" {
  description = "Backend pool ID from the load balancer"
  type        = string
  default     = null
}

variable "vm_size" {
  description = "VM size for the scale set"
  type        = string
  default     = "Standard_B2s"
}

variable "instance_count" {
  description = "Number of VM instances"
  type        = number
  default     = 2
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for admin access"
  type        = string
}

variable "disk_encryption_set_id" {
  description = "Optional Disk Encryption Set (backed by Key Vault CMK). If null, defaults to Microsoft-managed keys."
  type        = string
  default     = null
}

variable "vault_name" {
  type = string
}


variable "tags" {
  description = "Tags for the VMSS"
  type        = map(string)
  default     = {}
}
