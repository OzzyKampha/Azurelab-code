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
resource "azurerm_network_interface" "linux-nic1" {
  name                = "Linux-Network-Interface1"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "linux-NicConfiguration1"

    # Connect Linux machine to client subnet
    subnet_id                     = data.azurerm_subnet.lab-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  # Create Tags 
  tags = var.tags
}

data "azurerm_image" "packer-image" {
  name                  = "ubuntu-docker-v2"
  resource_group_name   = "images-labnet"
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
  network_interface_ids = [azurerm_network_interface.linux-nic1.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Create Linux Virtual Machine from this Custom Azure Image
  source_image_id = data.azurerm_image.packer-image.id

  # Create Tags 
  tags = var.tags
}
