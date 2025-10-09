variable "rg_name" {
   type = string
   description = "The variables for defining resource group name"
}

variable "rg_location" {
   type = string
   description = "The variable for defining resource group location"
}

variable "acr_name" {
    type = string
}

variable "acr_sku" {
    type = string
}

variable "aks_name" {
    type = string
}

variable "node_count" {
    type = number  
}

variable "env" {
    type = string 
}