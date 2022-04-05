resource "azurerm_public_ip" "vgw-hub-pip" {
    name                = "${var.vgw-hub}-pip"
    location            = var.rg-location
    resource_group_name = var.rg-name-hub

    allocation_method = "Dynamic"
}


resource "azurerm_virtual_network_gateway" "vgw-hub" {
    name                = var.vgw-hub
    location            = var.rg-location
    resource_group_name = var.rg-name-hub

    type     = "ExpressRoute"
    vpn_type = "RouteBased"

    sku           = "Standard"

    ip_configuration {
    name                          = "${var.vgw-hub}-pip"
    public_ip_address_id          = azurerm_public_ip.vgw-hub-pip.id
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
    }

    depends_on = [azurerm_public_ip.vgw-hub-pip]

}

