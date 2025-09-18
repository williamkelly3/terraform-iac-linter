output "name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.this.name
}

output "vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

output "vault_uri" {
  description = "Vault URI"
  value       = azurerm_key_vault.this.vault_uri
}

output "cmk_id" {
  description = "ID of the customer-managed key (if created)"
  value       = try(azurerm_key_vault_key.this[0].id, null)
}

output "des_id" {
  description = "ID of the disk encryption set (if created)"
  value       = try(azurerm_disk_encryption_set.this[0].id, null)
}

output "secret_id" {
  description = "The ID of the app password secret"
  value       = azurerm_key_vault_secret.app_password.id
}
