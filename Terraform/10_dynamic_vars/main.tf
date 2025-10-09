resource "azurerm_resource_group" "rg2" {
    name        = var.env_prod == "yes" ? "prod-rg" : "dev-rg"
    location    = var.env_prod == "yes" ? "eastus" : "westus"
}

resource "azurerm_virtual_network" "vnet1" {
    name                = var.env_prod == "yes" ? "prod-vnet" : "dev-vnet"
    location            = azurerm_resource_group.rg2.location
    resource_group_name = azurerm_resource_group.rg2.name
    address_space       = var.env_prod == "yes" ? ["10.100.0.0/16"] : ["10.200.0.0/16"]
}
