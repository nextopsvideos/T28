resource "azurerm_resource_group" "rg1" {
  name      = "pdrg01"
  location  = "eastus"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                      = "nextopsvnet01"
  resource_group_name       = "pdrg01" 
  location                  = "eastus"
  address_space             = ["10.3.0.0/16"]  

  depends_on = [ azurerm_resource_group.rg1 ]
}

resource "azurerm_subnet" "subnet" {
  name                      = "subnet1"
  resource_group_name       = "pdrg01"
  virtual_network_name      = "nextopsvnet01"
  address_prefixes          = ["10.3.0.0/24"]

  depends_on = [ 
    azurerm_resource_group.rg1,
    azurerm_virtual_network.vnet 
  ] 
}

# Meta arguments
# provider
# count
# for_each
# depends_on
# life_cycle