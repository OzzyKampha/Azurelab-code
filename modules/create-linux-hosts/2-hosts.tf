# Create Linux Virtual Machines
resource "azurerm_linux_virtual_machine" "vm" {
  for_each              = toset(var.vm_name)
  name                  = "${each.value}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  size                  = "${var.vm_size}"
  admin_username        = "${var.admin_username}"
  admin_password        = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.primary[each.key].id]

  # Cloud-init
  custom_data           = filebase64("${var.file_path}create-linux-hosts/files/cloud-init.yml")

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags         = "${var.tags}"

}