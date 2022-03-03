# Create Virtual Network (VNET)
resource "azurerm_virtual_network" "vnet" {
  name                = "Bastionvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name

  # Create Tags 
  tags = var.tags
}

# Create Bastion Subnet (SUBNET)
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.bastion.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.192/26"]
}

# Create Lab subnet (SUBNET)
resource "azurerm_subnet" "lab-subnet" {
  name                 = "AzureLabSubnet"
  resource_group_name  = azurerm_resource_group.bastion.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
