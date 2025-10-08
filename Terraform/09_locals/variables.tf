variable "rg_name" {
    type            = string 
    description     = "this variable is defined to store rg name value"
}

variable "rg_location" {
    type            = string 
    description     = "this variable is defined to store rg location value"
}

variable "vnet_name" {
    type            = string 
}

variable "vnet_address_space" {
    type            = list(string)
}

variable "subnet_name" {
    type            = string 
}

variable "subnet_address_prefix" {
    type            = list(string)
}