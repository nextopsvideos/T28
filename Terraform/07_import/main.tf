resource "azurerm_resource_group" "rg1" {
    name        = "NextOpsRG01"
    location    = "eastus"  
}

resource "azurerm_virtual_network" "vnet1" {
    name                    = "NextOpsVNET03"
    resource_group_name     = azurerm_resource_group.rg1.name 
    location                = azurerm_resource_group.rg1.location
    address_space           = ["10.20.0.0/16"]  
}

resource "azurerm_subnet" "subnet1" {
    name                  = "Subnet01"
    resource_group_name   = azurerm_resource_group.rg1.name 
    virtual_network_name  = azurerm_virtual_network.vnet1.name 
    address_prefixes      = ["10.20.0.0/24"]
}

resource "azurerm_subnet" "subnet2" {
    name                  = "AzureBastionSubnet"
    resource_group_name   = azurerm_resource_group.rg1.name 
    virtual_network_name  = azurerm_virtual_network.vnet1.name 
    address_prefixes      = ["10.20.2.0/26"] 
}

resource "azurerm_subnet" "subnet3" {
    name                  = "AzureFirewallManagementSubnet"
    resource_group_name   = azurerm_resource_group.rg1.name 
    virtual_network_name  = azurerm_virtual_network.vnet1.name 
    address_prefixes      = ["10.20.2.128/26"] 
}