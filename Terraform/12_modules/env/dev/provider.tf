terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.47.0"
    }
  }
  backend "azurerm" {
    use_cli              = true                                    
    use_azuread_auth     = true                                    
    tenant_id            = "9085ff8c-8807-4ff8-a403-ea470525cda6"
    storage_account_name = "nextopssat28"                                 
    container_name       = "modules"                                  
    key                  = "DEV/terraform.tfstate"     
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  subscription_id = "a355c32e-4a22-4b05-aab4-be236850fa6e"
}