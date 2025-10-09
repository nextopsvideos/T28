module "qa" {
    source      = "../../aks"
    rg_name     = "QaEnvRG"
    rg_location = "centralus"
    acr_name    = "noqaacrt28"
    acr_sku     = "Basic"
    aks_name    = "noqaakst28"
    node_count  = 1
    env         = "qa"
}