data "azurerm_resource_group" "existingrg" {
    name        = "NextOpsRG01"
}

data "azurerm_virtual_network" "existingvnet" {
  name                  = "NextOpsVNET03"
  resource_group_name   = data.azurerm_resource_group.existingrg.name
}

resource "azurerm_subnet" "newsubnet" {
  name                  = "Subnet02"
  resource_group_name   = data.azurerm_resource_group.existingrg.name 
  virtual_network_name  = data.azurerm_virtual_network.existingvnet.name 
  address_prefixes      = ["10.20.1.0/24"]  
}