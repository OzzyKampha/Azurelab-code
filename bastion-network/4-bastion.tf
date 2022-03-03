# Bastion Public IP
resource "azurerm_public_ip" "publicip" {
  name                = "bastionpip"
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name
  allocation_method   = "Static"
  sku                 = "Standard"

  # Create Tags 
  tags = var.tags
}

# Azure Bastion Host Creation
resource "azurerm_bastion_host" "bastionhost" {
  name                = "azurebastion"
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name
  sku                 = "Standard"
  copy_paste_enabled  = true
  file_copy_enabled   = true
  ip_connect_enabled  = true

  ip_configuration {
    name                 = "bastion_configuration"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.publicip.id
    
  }

  # Create Tags 
  tags = var.tags
}