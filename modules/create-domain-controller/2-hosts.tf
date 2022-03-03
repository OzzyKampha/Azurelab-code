####################################
# Create Virtual Machine
####################################

data "azurerm_image" "packer-image" {
  name                  = "server2019-v2"
  resource_group_name   = "images-labnet"
}

# Create Windows Domain Controller
resource "azurerm_windows_virtual_machine" "dc" {
  name                  = "dc"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  size                  = "${var.vm_size}"
  admin_username        = "${var.admin_username}"
  admin_password        = "${var.admin_password}"
  provision_vm_agent    = "true"
  custom_data           = filebase64("${var.file_path}create-domain-controller/files/bootstrap.ps1")
  network_interface_ids = [azurerm_network_interface.dc-nic.id]

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
    content = file("${var.file_path}create-domain-controller/files/FirstLogonCommands.xml")
    setting = "FirstLogonCommands"
  }


  /*
  # Create Windows Image
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  } 
  */

  # Create Windows Virtual Machine from this Custom Azure Image
  source_image_id = data.azurerm_image.packer-image.id

  # Create Tags 
  tags = var.tags

}