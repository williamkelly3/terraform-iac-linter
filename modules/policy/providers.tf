terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"   # ✅ correct source
      version = ">=1.5.0"
    }
  }
}
provider "azapi" {}
