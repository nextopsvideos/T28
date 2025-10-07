resource "azurerm_resource_group" "rg2" {
  name     = "SecondTFRG"
  location = "westus"
}

resource "azurerm_service_plan" "asp1" {
  name                = "nextopsaspt28"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_resource_group.rg2.location
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "app1" {
  name                = "nextopswat28"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_service_plan.asp1.location
  service_plan_id     = azurerm_service_plan.asp1.id

  site_config {}
}