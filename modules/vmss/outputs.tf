output "vmss_id" {
  description = "The ID of the VM scale set"
  value       = azurerm_linux_virtual_machine_scale_set.this.id
}

output "vmss_identity" {
  description = "System-assigned managed identity of the VMSS"
  value       = azurerm_linux_virtual_machine_scale_set.this.identity[0].principal_id
}

output "identity_principal_id" {
  value = azurerm_linux_virtual_machine_scale_set.this.identity[0].principal_id
}
