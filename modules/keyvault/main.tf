data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.sku_name
  purge_protection_enabled    = true
  soft_delete_retention_days  = 90

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Update", "Delete",
      "Recover", "Backup", "Restore", "Import"
    ]
  }

  tags = var.tags
}

resource "azurerm_key_vault_key" "this" {
  count        = var.create_cmk ? 1 : 0
  name         = "${var.name}-cmk"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048
  depends_on   = [azurerm_key_vault.this]
}

resource "azurerm_disk_encryption_set" "this" {
  count               = var.create_cmk ? 1 : 0
  name                = "${var.name}-des"
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = azurerm_key_vault_key.this[0].id

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_key_vault_key.this]
}
