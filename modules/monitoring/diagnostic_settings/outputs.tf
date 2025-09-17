output "diagnostic_setting_id" {
  description = "The ID of the diagnostic setting created."
  value       = azurerm_monitor_diagnostic_setting.this.id
}
