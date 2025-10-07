resource "azurerm_resource_group" "rg1" {
    name        = "FirstTFRG"
    location    = "eastus"
}

resource "azurerm_virtual_network" "vnet1" {
    name                = "nextopsvnet28"
    location            = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    address_space       = ["10.100.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
    name                    = "Subnet01"
    virtual_network_name    = azurerm_virtual_network.vnet1.name
    resource_group_name     = azurerm_resource_group.rg1.name 
    address_prefixes        = [ "10.100.0.0/24" ]     
}

resource "azurerm_subnet" "subnet2" {
    name                    = "Subnet02"
    virtual_network_name    = azurerm_virtual_network.vnet1.name
    resource_group_name     = azurerm_resource_group.rg1.name 
    address_prefixes        = [ "10.100.1.0/24" ]     
}

resource "azurerm_subnet" "subnet3" {
    name                    = "Subnet03"
    virtual_network_name    = azurerm_virtual_network.vnet1.name
    resource_group_name     = azurerm_resource_group.rg1.name 
    address_prefixes        = [ "10.100.2.0/24" ]     
}