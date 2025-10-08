locals {
  rg_name       = azurerm_resource_group.rg2.name
  rg_location   = azurerm_resource_group.rg2.location
  vnet_name     = azurerm_virtual_network.vnet1.name
  prefix        = "nextops"
}

resource "azurerm_resource_group" "rg2" {
    name        = var.rg_name
    location    = var.rg_location
}

resource "azurerm_virtual_network" "vnet1" {
    name                = join("-",[local.prefix,var.vnet_name]) #nextops-LocalsRG
    location            = local.rg_location
    resource_group_name = local.rg_name
    address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet1" {
    name                    = join("-",[local.prefix,var.subnet_name]) #nextops-subnet01
    virtual_network_name    = local.vnet_name
    resource_group_name     = local.rg_name
    address_prefixes        = var.subnet_address_prefix  
}