resource "azurerm_resource_group" "rg2" {
  name     = "LCCBDRG"
  location = "westus"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_service_plan" "asp1" {
  name                = "nextopsaspt29"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_resource_group.rg2.location
  os_type             = "Linux"
  sku_name            = "S1"
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_linux_web_app" "app1" {
  name                = "nextopswat29"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_service_plan.asp1.location
  service_plan_id     = azurerm_service_plan.asp1.id

  site_config {}
  lifecycle {
    create_before_destroy = true
  }
}