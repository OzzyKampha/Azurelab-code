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