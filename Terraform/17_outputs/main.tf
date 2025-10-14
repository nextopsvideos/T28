resource "azurerm_resource_group" "example" {
  name     = "output-demo"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "op-demo"
  address_space       = ["10.70.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

output "vnet_dns_servers" {
  value = azurerm_virtual_network.example.dns_servers
}

output "rg_resource_id" {
  value = azurerm_virtual_network.example.id
}

output "vnet_resource_id" {
  value = azurerm_virtual_network.example.id
}