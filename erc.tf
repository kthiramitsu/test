resource "azurerm_express_route_circuit" "erc-hub" {
    name                     = var.erc-hub
    resource_group_name      = var.rg-name-hub
    location                 = var.rg-location
    service_provider_name    = "Softbank"
    peering_location         = "Osaka"
    bandwidth_in_mbps        = 50
    sku {
        tier   = "Standard"
        family = "MeteredData"
    }
    allow_classic_operations = false
}