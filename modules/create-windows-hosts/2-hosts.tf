data "azurerm_image" "packer-image" {
  name                  = "windows10-software-v2"
  resource_group_name   = "images-labnet"
}

# Create Windows Virtual Machine 
resource "azurerm_windows_virtual_machine" "vm" {
  for_each              = toset(var.windows_vm_name)
  name                  = "${each.value}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  size                  = "Standard_D1_v2"
  admin_username        = "${var.admin_username}"
  admin_password        = "${var.admin_password}"
  provision_vm_agent    = "true"
  custom_data           = filebase64("${var.file_path}create-windows-hosts/files/bootstrap.ps1")
  network_interface_ids = [azurerm_network_interface.primary[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Additional setup Part 1
  additional_unattend_content {
    content = "<AutoLogon><Password><Value>${var.admin_password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.admin_username}</Username></AutoLogon>"
    setting = "AutoLogon"
  }

  # Additional setup Part 2
  additional_unattend_content {
    content = file("${var.file_path}create-windows-hosts/files/FirstLogonCommands.xml")
    setting = "FirstLogonCommands"
  }

  /*
  # Create Windows Image
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-21h2-pron"
    version   = "latest"
  } 
  */

  # Create Windows Virtual Machine from this Custom Azure Image
  source_image_id = data.azurerm_image.packer-image.id

  # Create Tags 
  tags = var.tags
}


