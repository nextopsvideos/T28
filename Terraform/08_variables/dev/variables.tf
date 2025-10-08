variable "rg_name" {
    type            = string 
    description     = "this variable is defined to store rg name value"
}

variable "rg_location" {
    type            = string 
    description     = "this variable is defined to store rg location value"
}

variable "acr_name" {
    type            = string 
}

variable "acr_sku" {
    type            = string 
}

variable "aks_name" {
    type            = string 
}

variable "env" {
    type            = string
}

variable "node_count" {
    type            = number 
}