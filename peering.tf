/*01toHub　仮想ネットワークピアリング*/
resource "azurerm_virtual_network_peering" "peering-01-to-hub" {
    name                      = "peering-01-to-hub"
    resource_group_name       = var.rg-name-01
    virtual_network_name      = var.vnet-name-01
    remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = true
    depends_on = [azurerm_virtual_network.vnet-01, azurerm_virtual_network.vnet-hub , azurerm_virtual_network_gateway.vgw-hub]
}

resource "azurerm_virtual_network_peering" "peering-hub-to-01" {
    name                      = "peering-hub-to-01"
    resource_group_name       = var.rg-name-hub
    virtual_network_name      = var.vnet-name-hub
    remote_virtual_network_id = azurerm_virtual_network.vnet-01.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = false
    depends_on = [azurerm_virtual_network.vnet-01, azurerm_virtual_network.vnet-hub , azurerm_virtual_network_gateway.vgw-hub]
}

/*02toHub 　仮想ネットワークピアリング*/
resource "azurerm_virtual_network_peering" "peering-02-to-hub" {
    name                      = "peering-02-to-hub"
    resource_group_name       = var.rg-name-02
    virtual_network_name      = var.vnet-name-02
    remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = true
    depends_on = [azurerm_virtual_network.vnet-02, azurerm_virtual_network.vnet-hub , azurerm_virtual_network_gateway.vgw-hub]
}

resource "azurerm_virtual_network_peering" "peering-hub-to-02" {
    name                      = "peering-hub-to-02"
    resource_group_name       = var.rg-name-hub
    virtual_network_name      = var.vnet-name-hub
    remote_virtual_network_id = azurerm_virtual_network.vnet-02.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = false
    depends_on = [azurerm_virtual_network.vnet-02, azurerm_virtual_network.vnet-hub , azurerm_virtual_network_gateway.vgw-hub]
}
