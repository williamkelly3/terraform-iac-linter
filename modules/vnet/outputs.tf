output "vnet_id" {
  description = "The ID of the virtual network."
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "Map of subnet IDs by name."
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}
