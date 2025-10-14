resource "azurerm_resource_group" "example" {
  name     = "rg-null-resource-demo"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-demo"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  depends_on = [ azurerm_resource_group.example ]
}

resource "azurerm_subnet" "example" {
  name                 = "subnet-demo"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.10.1.0/24"]

  depends_on = [ azurerm_virtual_network.example ]
}

resource "azurerm_network_interface" "example" {
  name                = "nic-demo"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig-demo"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ azurerm_subnet.example ]
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "NextOpsVML01"
  location                        = azurerm_resource_group.example.location
  resource_group_name             = azurerm_resource_group.example.name
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [ azurerm_network_interface.example.id ]

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

  depends_on = [ azurerm_resource_group.example,
                 azurerm_virtual_network.example,
                 azurerm_subnet.example,
                 azurerm_network_interface.example ]  
 
}

#Private DNS Zone
resource "azurerm_private_dns_zone" "example" {
  name                = "private.demo.local"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "dns-link-demo"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = azurerm_virtual_network.example.id  
}

resource "null_resource" "nr1" {
  triggers = {
    vm_private_ip = azurerm_network_interface.example.private_ip_address
  }  

  provisioner "local-exec" {
    command = "az network private-dns record-set a add-record --resource-group ${azurerm_resource_group.example.name} --zone-name ${azurerm_private_dns_zone.example.name} --record-set-name vm-demo --ipv4-address ${azurerm_network_interface.example.private_ip_address}"
  }

  depends_on = [ azurerm_network_interface.example,
  azurerm_linux_virtual_machine.main ]  
}