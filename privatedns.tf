/*プライベートDNSゾーン*/
resource "azurerm_private_dns_zone" "privatedns" {
    name = "test.com"
    resource_group_name = var.rg-name-hub
  
}

/*DNSレコード*/
resource "azurerm_private_dns_a_record" "test" {
    name = "kt"
    zone_name = "test.com"
    resource_group_name = var.rg-name-hub
    ttl = 300
    records = ["10.189.16.10"]  
}

/*仮想ネットワークリンク*/
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-hub" {
      name                  = var.vnet-name-hub
      resource_group_name   = var.rg-name-hub
      private_dns_zone_name = "test.com"
      virtual_network_id    = azurerm_virtual_network.vnet-hub.id

}
