/*ファイアウォール*/
resource "azurerm_public_ip" "fw-hub-pip" {
  name                = "${var.fw-hub}-pip"
  location            = var.rg-location
  resource_group_name = var.rg-name-hub
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw-hub" {
  name                = var.fw-hub
  location            = var.rg-location
  resource_group_name = var.rg-name-hub
  sku_tier = "Standard"

  dns_servers = ["168.63.129.16"] 
  

  ip_configuration {
    name                 = "${var.fw-hub}-pip"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.fw-hub-pip.id

  }
 }



/*ファイアウォールポリシー*/
resource "azurerm_firewall_policy" "fw-hub-policy" {
  name                = "${var.fw-hub}-policy"
  resource_group_name = var.rg-name-hub
  location            = var.rg-location

 


}



/*ファイアウォールポリシールール*/

resource "azurerm_firewall_policy_rule_collection_group" "fw-hub-rcg"{ 
name               = "${var.fw-hub}-rcg"
firewall_policy_id = azurerm_firewall_policy.fw-hub-policy.id
priority = 500

application_rule_collection {
    name = "WindowsUpdateCollection"
    priority = 200
    action = "Allow"
    rule {
        name = "Windows_Update"
        protocols {
          type = "Http"
          port = 80
        }
        protocols {
          type = "Https"
          port = 443
        }
        source_addresses = ["*"]
        destination_fqdn_tags = ["WindowsUpdate"]

    }
}
}