resource "azurerm_resource_group" "rg1" {
  for_each      = var.resourcedetails       #2
  name          = each.value.rg_name       #eastRG, westRG
  location      = each.value.rg_location    #eastus, westus
}

resource "azurerm_virtual_network" "vnet1" {
  for_each              = var.resourcedetails 
  name                  = each.value.vnet_name
  resource_group_name   = azurerm_resource_group.rg1[each.key].name 
  location              = azurerm_resource_group.rg1[each.key].location
  address_space         = each.value.address_space
}

resource "azurerm_subnet" "subnet" {
  for_each              = var.resourcedetails   
  name                  = each.value.subnet_name
  virtual_network_name  = azurerm_virtual_network.vnet1[each.key].name 
  resource_group_name   = azurerm_resource_group.rg1[each.key].name
  address_prefixes      = each.value.address_prefix
}


resource "azurerm_network_interface" "mynic" {
  for_each = var.resourcedetails

  name                = each.value.nic_name
  location            = azurerm_resource_group.rg1[each.key].location
  resource_group_name = azurerm_resource_group.rg1[each.key].name
  ip_configuration {
    name                          = "my-ip-config"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "vm" {
  for_each = var.resourcedetails

  name                  = each.value.vm_name
  location              = azurerm_resource_group.rg1[each.key].location
  resource_group_name   = azurerm_resource_group.rg1[each.key].name
  network_interface_ids = [azurerm_network_interface.mynic[each.key].id]
  vm_size               = each.value.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${each.value.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.value.vm_name
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}