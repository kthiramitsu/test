resource "azurerm_virtual_network" "vnet-hub" {
    name = var.vnet-name-hub
    location = var.rg-location
    resource_group_name = var.rg-name-hub
    address_space       = ["10.189.0.0/22"]
    dns_servers = ["10.189.0.196"]

    tags = {
    productname = "Hub" 
    }
}

/*サブネット*/

resource "azurerm_subnet" "vnet-hub-subnet" {
    name                 = "${var.vnet-name-hub}-subnet"
    resource_group_name  = var.rg-name-hub
    virtual_network_name = var.vnet-name-hub
    address_prefixes     = ["10.189.0.0/26"]
}

resource "azurerm_subnet" "vnet-hub-subnet-dns" {
    name                 = "${var.vnet-name-hub}-subnet-dns"
    resource_group_name  = var.rg-name-hub
    virtual_network_name = var.vnet-name-hub
    address_prefixes     = ["10.189.0.64/26"]
}

resource "azurerm_subnet" "GatewaySubnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = var.rg-name-hub
    virtual_network_name = var.vnet-name-hub
    address_prefixes     = ["10.189.0.128/26"] 
}

resource "azurerm_subnet" "AzureFirewallSubnet" {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = var.rg-name-hub
    virtual_network_name = var.vnet-name-hub
    address_prefixes     = ["10.189.0.192/26"] 
}


/*NSG*/

resource "azurerm_network_security_group" "vnet-hub-nsg" {
  name                = "${var.vnet-name-hub}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-name-hub

  tags = {
  ProjectName = "Hub" 
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-association-hub" {
    subnet_id                 = azurerm_subnet.vnet-hub-subnet.id
    network_security_group_id = azurerm_network_security_group.vnet-hub-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-association-dns" {
    subnet_id                 = azurerm_subnet.vnet-hub-subnet-dns.id
    network_security_group_id = azurerm_network_security_group.vnet-hub-nsg.id
}
