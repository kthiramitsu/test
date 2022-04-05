/*仮想ネットワーク*/
resource "azurerm_virtual_network" "vnet-01" {
    name = var.vnet-name-01
    location = var.rg-location
    resource_group_name = var.rg-name-01
    address_space       = ["10.189.16.0/26"]
    dns_servers = ["10.189.0.196"]

    tags = {
    ProjectName = "C2App1" 
    }
}

/*サブネット*/

resource "azurerm_subnet" "vnet-01-subnet" {
    name                 = "${var.vnet-name-01}-subnet"
    resource_group_name  = var.rg-name-01
    virtual_network_name = var.vnet-name-01
    address_prefixes     = ["10.189.16.0/28"]
    service_endpoints = ["Microsoft.Storage","Microsoft.Eventhub"]
}

/*NSG*/

resource "azurerm_network_security_group" "vnet-01-nsg" {
  name                =  "${var.vnet-name-01}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-name-01

security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    ProjectName = "C2App1" 
  }
}



resource "azurerm_subnet_network_security_group_association" "subnet-nsg-association" {
    subnet_id                 = azurerm_subnet.vnet-01-subnet.id
    network_security_group_id = azurerm_network_security_group.vnet-01-nsg.id
}

/*NSGフローログ設定*/


resource "azurerm_network_watcher_flow_log" "vnet-01-nsg-flowlog" {
  network_watcher_name = "NetworkWatcher_japanwest"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.vnet-01-nsg.id
  storage_account_id        = azurerm_storage_account.storagebase01.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 0
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.LA-base.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.LA-base.location
    workspace_resource_id = azurerm_log_analytics_workspace.LA-base.id
    interval_in_minutes   = 10
  }
}



/*vm-01ネットワークインターフェース*/
resource "azurerm_network_interface" "vm-01-nic" {
name =  "${var.vm-name-01}-nic"
location = var.rg-location
resource_group_name = var.rg-name-01
ip_configuration {
name = "ipconfig"
subnet_id = azurerm_subnet.vnet-01-subnet.id
private_ip_address_allocation = "Dynamic"
}

tags = {
    ProjectName = "C2App1" 
    }

}

resource "azurerm_network_security_group" "vm-01-nsg" {
  name                =  "${var.vm-name-01}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-name-01

security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    ProjectName = "C2App1" 
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.vm-01-nic.id
    network_security_group_id = azurerm_network_security_group.vm-01-nsg.id
}


/*vm-02ネットワークインターフェース*/


resource "azurerm_network_interface" "vm-02-nic" {
name =  "${var.vm-name-02}-nic"
location = var.rg-location
resource_group_name = var.rg-name-01
ip_configuration {
name = "ipconfig"
subnet_id = azurerm_subnet.vnet-01-subnet.id
private_ip_address_allocation = "Dynamic"
}

tags = {
    ProjectName = "C2App1" 
    }

}

resource "azurerm_network_security_group" "vm-02-nsg" {
  name                =  "${var.vm-name-02}-nsg"
  location = var.rg-location
  resource_group_name = var.rg-name-01

security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    ProjectName = "C2App1" 
  }
}

resource "azurerm_network_interface_security_group_association" "test" {
    network_interface_id      = azurerm_network_interface.vm-02-nic.id
    network_security_group_id = azurerm_network_security_group.vm-02-nsg.id
}




