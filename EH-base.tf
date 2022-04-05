resource "azurerm_eventhub_namespace" "EH-base" {
  name                = var.EH-name-base
  location            = var.rg-location
  resource_group_name = var.rg-name-hub
  sku                 = "Standard"

tags = {
ProjectName = "Hub" 
     }

}


resource "azurerm_eventhub" "EH-base-hub" {
  name                = "${var.EH-name-base}-hub"
  namespace_name      = var.EH-name-base
  resource_group_name = var.rg-name-hub
  partition_count     = 2
  message_retention   = 1
}


