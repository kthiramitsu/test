resource "azurerm_virtual_network" "vnet-02" {
    name = var.vnet-name-02
    location = var.rg-location
    resource_group_name = var.rg-name-02
    address_space       = ["10.189.16.64/26"]
    dns_servers = ["10.189.0.196"]

    tags = {
    ProjectName = "C3App2" 
    }
}

/*サブネット*/

resource "azurerm_subnet" "vnet-02-subnet" {
    name                 = "${var.vnet-name-02}-subnet"
    resource_group_name  = var.rg-name-02
    virtual_network_name = var.vnet-name-02
    address_prefixes     = ["10.189.16.64/28"]
}

/*NSG*/

resource "azurerm_network_security_group" "vnet-02-nsg" {
  name                = "${var.vnet-name-02}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-name-02

  tags = {
  ProjectName = "C3App2" 
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-association-02" {
    subnet_id                 = azurerm_subnet.vnet-02-subnet.id
    network_security_group_id = azurerm_network_security_group.vnet-02-nsg.id
}