resource "azurerm_linux_virtual_machine" "vm-02" {
    name                  = var.vm-name-02
    location              = var.rg-location
    resource_group_name   = var.rg-name-01
    network_interface_ids = [azurerm_network_interface.vm-02-nic.id]
    size                  = "Standard_B1ms"

    os_disk {
        name              = "${var.vm-name-02}-osdisk"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }



    computer_name  = var.vm-name-02
    admin_username = "${var.admin-username}"
    admin_password = "${var.admin-password}"
    disable_password_authentication = false


    tags = {
        environment = "Terraform Demo"
    }
}