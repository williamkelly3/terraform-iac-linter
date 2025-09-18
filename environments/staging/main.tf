module "vnet" {
  source              = "../../modules/vnet"
  name                = "staging-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = ["10.20.0.0/16"]

  subnets = [
    {
      name             = "mgmt"
      address_prefixes = ["10.20.1.0/24"]
    },
    {
      name             = "app"
      address_prefixes = ["10.20.2.0/24"]
    },
    {
      name             = "db"
      address_prefixes = ["10.20.3.0/24"]
    }
  ]

  tags = var.tags
}

module "storage" {
  source              = "../../modules/storage"
  name                = "stagingstorageacct"
  location            = var.location
  resource_group_name = var.resource_group_name
  account_tier        = "Standard"
  replication_type    = "GRS"

  tags = var.tags
}

module "vmss" {
  source              = "../../modules/vmss"
  name                = "staging-vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.vnet.subnet_ids["app"]

  vm_size        = "Standard_B2ms"
  instance_count = 2
  admin_username = "azureuser"
  ssh_public_key = var.ssh_public_key

  tags = var.tags
}

module "keyvault" {
  source              = "../../modules/keyvault"
  name                = "staging-kv01"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  create_cmk          = true
  key_expiration_date = "2027-01-01T00:00:00Z"

  create_private_endpoint      = false
  network_acls_vnet_subnet_ids = [module.vnet.subnet_ids["mgmt"]]

  tags = var.tags
}

module "monitoring" {
  source              = "../../modules/monitoring"
  name                = "staging-monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name
  retention_in_days   = 30

  tags = var.tags
}

module "storage_diagnostics" {
  source = "../../modules/monitoring/diagnostic_settings"

  target_resource_id          = module.storage.storage_account_id
  target_resource_name        = "storage"
  log_analytics_workspace_id  = module.monitoring.log_analytics_workspace_id

  log_categories    = ["StorageRead", "StorageWrite", "StorageDelete"]
  metric_categories = ["AllMetrics"]
}

module "keyvault_diagnostics" {
  source = "../../modules/monitoring/diagnostic_settings"

  target_resource_id          = module.keyvault.vault_id
  target_resource_name        = "keyvault"
  log_analytics_workspace_id  = module.monitoring.log_analytics_workspace_id

  log_categories    = ["AuditEvent"]
  metric_categories = ["AllMetrics"]
}

module "vmss_diagnostics" {
  source = "../../modules/monitoring/diagnostic_settings"

  target_resource_id          = module.vmss.vmss_id
  target_resource_name        = "vmss"
  log_analytics_workspace_id  = module.monitoring.log_analytics_workspace_id

  log_categories    = ["VMSSOperations"]
  metric_categories = ["AllMetrics"]
}
