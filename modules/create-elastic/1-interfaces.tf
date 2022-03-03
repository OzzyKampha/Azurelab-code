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
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.20"        
  }

  # Create Tags 
  tags = var.tags
}