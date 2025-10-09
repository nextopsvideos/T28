module "dev" {
    source      = "../../aks"
    rg_name     = "DevEnvRG"
    rg_location = "eastus"
    acr_name    = "nodevacrt28"
    acr_sku     = "Standard"
    aks_name    = "nodevakst28"
    node_count  = 2
    env         = "dev"
}