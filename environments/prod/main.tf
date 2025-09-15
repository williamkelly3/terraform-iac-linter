
module "storage" {
  source              = "../../modules/storage"
  name                = "prodstorageacct"
  resource_group_name = var.resource_group_name
  location            = var.location
  account_tier        = "Standard"
  replication_type    = "GRS"
  tags = {
    environment = "prod"
    owner       = "william.kelly"
  }
}

module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "my-vnet"
  address_space       = ["10.30.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  subnets = [
    {
      name             = "app"
      address_prefixes = ["10.30.1.0/24"]
    },
    {
      name             = "db"
      address_prefixes = ["10.30.2.0/24"]
    },
    {
      name             = "mgmt"
      address_prefixes = ["10.30.3.0/24"]
    }
  ]

  dns_servers              = []
  ddos_protection_plan_id  = null
}
