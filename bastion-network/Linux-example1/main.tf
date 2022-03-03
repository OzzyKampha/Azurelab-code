# Code to deploy a Linux node in a subnet that can be accessed by a alredy deployed Bastion host

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

# Create Internal network interface Linux (NIC)
resource "azurerm_network_interface" "linux-nic" {
  name                = "Linux-Network-Interface"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "linux-NicConfiguration"

    # Connect Linux machine to client subnet
    subnet_id                     = data.azurerm_subnet.lab-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  # Create Tags 
  tags = var.tags
}

# Create Linux Client Virtual Machines
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "linux-node1"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "${var.linux_vm_size}"
  admin_username        = "${var.admin_username}"
  admin_password        = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.linux-nic.id]

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

  # Create Tags 
  tags = var.tags
}
