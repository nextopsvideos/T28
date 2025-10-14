resource "azurerm_resource_group" "myrg1" {
    name        = var.rgname
    location    = var.location  
}

resource "azurerm_virtual_network" "myvnet1" {
    name  = "NextOpsVNET21"
    resource_group_name = azurerm_resource_group.myrg1.name
    location = azurerm_resource_group.myrg1.location
    address_space = ["${var.vnet_cidr_prefix}"]
}

resource "azurerm_subnet" "subnet1" {
    name = "Subnet1"
    resource_group_name = azurerm_resource_group.myrg1.name
    virtual_network_name = azurerm_virtual_network.myvnet1.name
    address_prefixes = ["${var.subnet1_cidr_prefix}"]  
}

resource "azurerm_public_ip" "myVMPIP01" {
  name                = "NextOpsVML02PIP01"
  resource_group_name = azurerm_resource_group.myrg1.name
  location = azurerm_resource_group.myrg1.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic1" {
  name                = "NextOpsVML02-nic"
  resource_group_name = azurerm_resource_group.myrg1.name
  location            = azurerm_resource_group.myrg1.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.myVMPIP01.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "NextOpsVML02"
  resource_group_name             = azurerm_resource_group.myrg1.name
  location                        = azurerm_resource_group.myrg1.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [ azurerm_network_interface.nic1.id ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  provisioner "local-exec" {
    command = "echo ${azurerm_public_ip.myVMPIP01.ip_address} >> publicip.txt"
  }
}