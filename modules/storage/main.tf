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
