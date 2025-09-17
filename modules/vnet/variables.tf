variable "name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_servers" {
  description = "List of DNS servers to use for the VNet."
  type        = list(string)
  default     = []
}

variable "ddos_protection_plan_id" {
  description = "ID of a DDoS protection plan. Leave null if not used."
  type        = string
  default     = null
}

variable "subnets" {
  description = <<EOT
List of subnet objects. Example:
[
  {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
    delegations = [
      {
        name         = "delegation1"
        service_name = "Microsoft.Web/serverFarms"
        actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    ]
  }
]
EOT
  type = list(object({
    name             = string
    address_prefixes = list(string)
    delegations = optional(list(object({
      name         = string
      service_name = string
      actions      = list(string)
    })), [])
  }))
}

variable "tags" {
  description = "Tags for the virtual network."
  type        = map(string)
  default     = {}
}
