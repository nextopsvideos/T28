# 1 resource group
# 1 vnet
# 3 subnets
# 3 network interface cards
# 3 virtual machines


resource "azurerm_resource_group" "rg1" {
    name    =   var.rg_name
    location  = var.rg_location  
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_subnet" "subnet1" {
  count                = length(var.subnet_name) #3 iterations
  name                 = var.subnet_name[count.index] # subnet_name[0] = "subnet1", subnet_name[1] = "subnet2", subnet_name[2] = "subnet3"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.40.${count.index}.0/24"] # 10.40.0.0/24, 10.40.1.0/24, 10.40.2.0/24
}

resource "azurerm_network_interface" "nic1" {
  count               = 3
  name                = "nextopsnic${count.index}" #nextopsnic0, nextopsnic1, nextopsnic2
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  count               = 3
  name                = "nextopsvm${count.index}" #nextopsvm0, nextopsvm1, nextopsvm2
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  
  network_interface_ids = [
    azurerm_network_interface.nic1[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    #ssh-keygen -t rsa -f C:\Class_Code\T27\Terraform\13_loops\count\SSH_Keys\id_rsa 
    public_key = file("C:/Class_Code/T28/Terraform/13_loops/count/SSH_Keysid_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}