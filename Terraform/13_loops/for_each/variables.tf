variable "resourcedetails" {
    type = map(object({
      rg_name           = string  
      rg_location       = string
      vnet_name         = string 
      address_space     = list(string)
      subnet_name       = string 
      address_prefix    = list(string)
      nic_name          = string
      vm_name           = string 
      vm_size           = string
    }))  
}