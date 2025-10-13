resource "azurerm_resource_group" "aksrg" {
  name              = var.rg_name       #AKSRG
  location          = var.rg_location   #eastus
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aksrg.name
  location            = azurerm_resource_group.aksrg.location
  sku                 = var.acr_sku
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.aksrg.location
  resource_group_name = azurerm_resource_group.aksrg.name
  dns_prefix          = "nextops"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.env
  }

  lifecycle {
    ignore_changes = [ default_node_pool[0].upgrade_settings ]
  }
}

resource "azurerm_role_assignment" "aks2acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}