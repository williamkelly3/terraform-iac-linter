module "vnet" {
  source              = "../../modules/vnet"
  vnet_name                = "staging-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.20.0.0/16"]

  subnets = [
    {
      name             = "app"
      address_prefixes = ["10.20.1.0/24"]
    },
    {
      name             = "db"
      address_prefixes = ["10.20.2.0/24"]
    },
    {
      name             = "mgmt"
      address_prefixes = ["10.20.3.0/24"]
    }
  ]

  dns_servers              = []
  ddos_protection_plan_id  = null
  tags = var.tags
}

module "storage" {
  source              = "../../modules/storage"
  name                = "stagingstorageacct"
  resource_group_name = var.resource_group_name
  location            = var.location
  account_tier        = "Standard"
  replication_type    = "GRS"
  tags = var.tags
}
