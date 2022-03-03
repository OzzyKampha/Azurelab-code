####################################
# Create Local Interface (NIC)
####################################

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

# Create network interface - DC-NIC
resource "azurerm_network_interface" "dc-nic" {
    name                      = "Domain_Controller_NIC"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group_name}"

    ip_configuration {
        name                          = "DC_NicConfiguration"
        subnet_id                     = data.azurerm_subnet.lab-subnet.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.2.10"
    }

  # Create Tags 
  tags = var.tags

}