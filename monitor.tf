/*アクショングループ*/
resource "azurerm_monitor_action_group" "main" {
  name                = "alert_mail"
  resource_group_name = var.rg-name-hub
  short_name          = "alertmail"

  email_receiver {
    name        = "sendmail"
    email_address = "kthiramitsu@nissho-ele.co.jp"
  }
}


/*アラートルール*/
resource "azurerm_monitor_metric_alert" "test1234" {
  name                = "example-metricalert"
  resource_group_name = var.rg-name-hub
  scopes              = [azurerm_storage_account.storagebase01.id]
  description         = "Action will be triggered when Transactions count is greater than 50."

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50

    dimension {
      name     = "ApiName"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}