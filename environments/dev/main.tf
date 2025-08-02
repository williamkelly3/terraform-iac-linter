provider "azurerm" {
  features {}
}

module "storage" {
  source              = "../../modules/storage"
  name                = "devstorageacct"
  resource_group_name = "rg-dev-resources"
  location            = "eastus"
  account_tier        = "Standard"
  replication_type    = "LRS"
  tags = {
    environment = "dev"
    owner       = "william.kelly"
  }
}
