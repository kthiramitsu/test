/*リソースグループ*/

/*C2*/
resource "azurerm_resource_group" "rg-01"{
    name = var.rg-name-01
    location = var.rg-location
}

/*C3*/
resource "azurerm_resource_group" "rg-02"{
    name = var.rg-name-02
    location = var.rg-location
}

/*Hub*/
resource "azurerm_resource_group" "rg-hub"{
    name = var.rg-name-hub
    location = var.rg-location
}



