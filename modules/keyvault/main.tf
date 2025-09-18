data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.sku_name
  purge_protection_enabled    = true
  soft_delete_retention_days  = var.soft_delete_retention_days

  # Disable public network access (enterprise default)
  public_network_access_enabled = false

  # Network ACLs - restrict traffic (default_action = Deny)
  network_acls {
    bypass                     = var.network_acls_bypass               # e.g., "AzureServices"
    default_action             = var.network_acls_default_action       # "Deny" or "Allow"
    ip_rules                   = var.network_acls_ip_rules
    virtual_network_subnet_ids = var.network_acls_vnet_subnet_ids
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Update", "Delete",
      "Recover", "Backup", "Restore", "Import"
    ]
  }

# Conditional policy for VMSS managed identity
  dynamic "access_policy" {
    for_each = var.vmss_identity_principal_id != null ? [var.vmss_identity_principal_id] : []
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = access_policy.value

      secret_permissions = ["Get", "List"]
    }

  tags = var.tags
}

# Create an HSM-backed key when create_cmk = true
resource "azurerm_key_vault_key" "this" {
  count        = var.create_cmk ? 1 : 0
  name         = "${var.name}-cmk"
  key_vault_id = azurerm_key_vault.this.id
  # Use HSM-backed key for enterprise-grade protection
  key_type     = var.key_type             # "RSA-HSM" recommended
  key_size     = var.key_size

  # key options (encrypt/decrypt/wrap/unwrap etc.)
  key_opts = var.key_opts

  # Set expiration date for the key (ISO8601 / RFC3339)
  # Use either expiration_date or expire_after depending on provider/version
  expiration_date = var.key_expiration_date
}

# Optional Disk Encryption Set referencing the Key Vault Key
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

# Optional Private Endpoint to put Key Vault inside your VNet (recommended for prod)
resource "azurerm_private_endpoint" "this" {
  count               = var.create_private_endpoint && var.private_endpoint_subnet_id != null ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

resource "azurerm_key_vault_access_policy" "vmss" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.vmss_identity_principal_id

  secret_permissions = ["Get", "List"]
}

