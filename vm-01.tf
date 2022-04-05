resource "azurerm_windows_virtual_machine" "vm-01" {
  name                  = var.vm-name-01
  location              = var.rg-location
  resource_group_name   = var.rg-name-01
  network_interface_ids = [azurerm_network_interface.vm-01-nic.id]
  size               = "Standard_B1ms"
  admin_username = "${var.admin-username}"
  admin_password = "${var.admin-password}"


source_image_reference {
publisher = "MicrosoftWindowsServer"
offer = "WindowsServer"
sku = "2019-datacenter-gensecond"
version = "latest"
}

os_disk {
    name              = "${var.vm-name-01}-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
    }

boot_diagnostics {
  storage_account_uri = azurerm_storage_account.storagebase01.primary_blob_endpoint
  }


tags = {
ProjectName = "C2App1"
}



}


