resource "azurerm_resource_group" "rg1" {
    name        = "FirstTFRG"
    location    = "eastus"
}

resource "azurerm_virtual_network" "vnet1" {
    name                = "nextopsvnet28"
    location            = "eastus"
    resource_group_name = "FirstTFRG"
    address_space       = ["10.100.0.0/16"]
}