terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.100.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "vnet" {
  name = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "vnet" {
  name = "vnet1"
  location = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet" {
  name = "subnet1"
  resource_group_name = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.0.1.0/24"]
}

module "manvm" {
  source = "./modules/vm"
  number_of_vm = var.number_of_vm
  resource_group_name = azurerm_resource_group.vnet.name
  resource_group_location = azurerm_resource_group.vnet.location
  subnetid = azurerm_subnet.vnet.id
  
}