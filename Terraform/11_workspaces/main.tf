resource "azurerm_resource_group" "rg1" {
   name         = var.rg_name
   location     = var.rg_location
}

resource "azurerm_virtual_network" "vnet1" {
   name                 = var.vnet_name   
   resource_group_name  = azurerm_resource_group.rg1.name
   location             = azurerm_resource_group.rg1.location
   address_space        = var.vnet_addressspace
}

resource "azurerm_subnet" "subnet1" {
   name                 = var.subnet_name
   resource_group_name  = azurerm_resource_group.rg1.name
   virtual_network_name = azurerm_virtual_network.vnet1.name
   address_prefixes     = var.subnet1_addressprefix
}