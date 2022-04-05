/*ルートテーブルC2*/
resource "azurerm_route_table" "routetable-01" {
  name = var.routetable-name-01
  location = var.rg-location
  resource_group_name = var.rg-name-01

tags = {
    ProjectName = "C2App1" 
    }

}

resource "azurerm_route" "routetable-01" {
  name = "${var.routetable-name-01}-01"
  resource_group_name = var.rg-name-01
  route_table_name = var.routetable-name-01
  address_prefix = "0.0.0.0/0"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "routetable-02" {
  name = "${var.routetable-name-01}-02"
  resource_group_name = var.rg-name-01
  route_table_name = var.routetable-name-01
  address_prefix = "10.189.0.0/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "routetable-03" {
  name = "${var.routetable-name-01}-03"
  resource_group_name = var.rg-name-01
  route_table_name = var.routetable-name-01
  address_prefix = "10.189.0.64/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}


resource "azurerm_subnet_route_table_association" "hubto01" {
 subnet_id = azurerm_subnet.vnet-01-subnet.id
 route_table_id = azurerm_route_table.routetable-01.id
 depends_on = [azurerm_subnet.vnet-01-subnet]    
  
}


/*ルートテーブルC3*/
resource "azurerm_route_table" "routetable-02" {
  name = var.routetable-name-02
  location = var.rg-location
  resource_group_name = var.rg-name-02

tags = {
    ProjectName = "C3App2" 
    }

}

resource "azurerm_route" "routetable-04" {
  name = "${var.routetable-name-02}-01"
  resource_group_name = var.rg-name-02
  route_table_name = var.routetable-name-02
  address_prefix = "0.0.0.0/0"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "routetable-05" {
  name = "${var.routetable-name-02}-02"
  resource_group_name = var.rg-name-02
  route_table_name = var.routetable-name-02
  address_prefix = "10.189.0.0/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "routetable-06" {
  name = "${var.routetable-name-02}-03"
  resource_group_name = var.rg-name-02
  route_table_name = var.routetable-name-02
  address_prefix = "10.189.0.64/26"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_subnet_route_table_association" "hubto02" {
 subnet_id = azurerm_subnet.vnet-02-subnet.id
 route_table_id = azurerm_route_table.routetable-02.id
 depends_on = [azurerm_subnet.vnet-02-subnet]    
  
}


/*ルートテーブルHub*/
resource "azurerm_route_table" "routetable-hub" {
  name = var.routetable-name-hub
  location = var.rg-location
  resource_group_name = var.rg-name-hub

tags = {
    ProjectName = "Hub" 
    }

}



resource "azurerm_route" "routetable-hub-02" {
  name = "${var.routetable-name-hub}-02"
  resource_group_name = var.rg-name-hub
  route_table_name = var.routetable-name-hub
  address_prefix = "10.189.16.0/28"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_route" "routetable-hub-03" {
  name = "${var.routetable-name-hub}-03"
  resource_group_name = var.rg-name-hub
  route_table_name = var.routetable-name-hub
  address_prefix = "10.189.16.64/28"
  next_hop_type = "virtualappliance"
  next_hop_in_ip_address = "10.189.0.196"

}

resource "azurerm_subnet_route_table_association" "hubtohub" {
 subnet_id = azurerm_subnet.vnet-hub-subnet.id
 route_table_id = azurerm_route_table.routetable-hub.id
 depends_on = [azurerm_subnet.vnet-hub-subnet]    
  
}



/*ファイアウォールルートテーブル*/

resource "azurerm_route_table" "routetable-fw" {
  name = var.routetable-name-fw
  location = var.rg-location
  resource_group_name = var.rg-name-hub

tags = {
    ProjectName = "Hub" 
    }

}


resource "azurerm_route" "routetable-fw" {
  name = "${var.routetable-name-fw}-01"
  resource_group_name = var.rg-name-hub
  route_table_name = var.routetable-name-fw
  address_prefix = "0.0.0.0/0"
  next_hop_type = "Internet"

}

resource "azurerm_subnet_route_table_association" "fw" {
 subnet_id = azurerm_subnet.AzureFirewallSubnet.id
 route_table_id = azurerm_route_table.routetable-fw.id
 depends_on = [azurerm_subnet.AzureFirewallSubnet]    
  
}