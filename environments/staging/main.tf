
module "storage" {
  source              = "../../modules/storage"
  name                = "stagestorageacct"
  resource_group_name = var.resource_group_name
  location            = var.location
  account_tier        = "Standard"
  replication_type    = "GRS"
  tags = {
    environment = "dev"
    owner       = "william.kelly"
  }
}

module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnets = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.2.0/24"
    }
  ]
}
