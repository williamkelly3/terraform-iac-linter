resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

  # ✅ Security / compliance best practices
  https_traffic_only_enabled      = true
  min_tls_version                = "TLS1_2"
  allow_nested_items_to_be_public  = false
  shared_access_key_enabled      = false
  public_network_access_enabled  = false

  # ✅ Soft delete (blob service)
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  # ✅ Logging example (Queue service)
  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 7
    }
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "this" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-pe-connection"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  count               = var.customer_managed_key_id != null ? 1 : 0
  storage_account_id  = azurerm_storage_account.this.id
  key_vault_id        = var.key_vault_id
  key_name            = var.customer_managed_key_name
  key_version         = var.customer_managed_key_version
}


