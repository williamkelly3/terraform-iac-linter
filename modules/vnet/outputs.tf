output "vnet_id" {
  description = "The ID of the virtual network."
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "Map of subnet IDs by name."
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "nsg_ids" {
  description = "Map of NSG IDs by subnet name."
  value       = { for k, v in azurerm_network_security_group.this : k => v.id }
}
