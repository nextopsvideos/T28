resourcedetails = {
  "eastus" = {
    rg_name         = "eastRG"
    rg_location     = "eastus"
    vnet_name       = "eastVNET"
    address_space   = ["10.100.0.0/16"]
    subnet_name     = "eastsubnet1"
    address_prefix  = ["10.100.0.0/24"]
    nic_name        = "eastvmnic1"
    vm_name         = "eastvm01"
    vm_size         = "Standard_B1s"   
  }
  "westus1" = {
    rg_name         = "westRG"
    rg_location     = "westus"
    vnet_name       = "westVNET"
    address_space   = ["10.200.0.0/16"]
    subnet_name     = "westsubnet1"
    address_prefix  = ["10.200.0.0/24"]
    nic_name        = "westvmnic1" 
    vm_name         = "westvm01"
    vm_size         = "Standard_B2s"      
  }
}