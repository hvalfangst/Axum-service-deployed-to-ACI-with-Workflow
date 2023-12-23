terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "hvalfangst" {
  location = "West Europe"
  name = "hvalfangstresourcegroup"
}

resource "azurerm_container_registry" "hvalfangst" {
  name                = "hvalfangstcontainerregistry"
  resource_group_name = azurerm_resource_group.hvalfangst.name
  location            = azurerm_resource_group.hvalfangst.location
  sku                 = "Basic"
  admin_enabled       = true
}







