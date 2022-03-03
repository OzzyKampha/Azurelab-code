# Code to deploy a Windows node in a subnet that can be accessed by a alredy deployed Bastion host

# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Retrive data from Bastion-Lab
# (MUST BE DEPLOYD BEFORE RUNNING THIS CODE)

data "azurerm_virtual_network" "vnet" {
  name                  = "Bastionvnet"
  resource_group_name   = var.resource_group_name
}

data "azurerm_subnet" "lab-subnet" {
  name                  = "AzureLabSubnet"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = data.azurerm_virtual_network.vnet.name
}

# Create Internal network interface (NIC)
resource "azurerm_network_interface" "primary" {
  name                = "${var.client_name}-primary"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "${var.client_name}-NicConfiguration"
    subnet_id                     = data.azurerm_subnet.lab-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  # Create Tags 
  tags = var.tags

}

data "azurerm_image" "packer-image" {
  name                  = "windows10-software-v2"
  resource_group_name   = "images-labnet"
}

# Create Windows Virtual Machine 
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.client_name}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  size                  = "${var.vm_size}"
  admin_username        = "${var.admin_username}"
  admin_password        = "${var.admin_password}"
  provision_vm_agent    = "true"
  custom_data           = filebase64("./files/bootstrap.ps1")
  network_interface_ids = [azurerm_network_interface.primary.id]

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
    content = file("./files/FirstLogonCommands.xml")
    setting = "FirstLogonCommands"
  }


  # Create Windows Virtual Machine from this Custom Azure Image
  source_image_id = data.azurerm_image.packer-image.id

  # Create Tags 
  tags = var.tags

}


