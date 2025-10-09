module "prod" {
    source      = "../../aks"
    rg_name     = "ProdEnvRG"
    rg_location = "westus"
    acr_name    = "noprodacrt28"
    acr_sku     = "Premium"
    aks_name    = "noprodakst28"
    node_count  = 3
    env         = "prod"
}