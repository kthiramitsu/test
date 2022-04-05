resource "azurerm_log_analytics_workspace""LA-base" {
name = var.LA-name-base
location = var.rg-location
resource_group_name = var.rg-name-hub

retention_in_days = 730

tags = {
ProjectName = "Hub" 
     }
}