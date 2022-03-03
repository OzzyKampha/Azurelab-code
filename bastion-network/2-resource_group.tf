# Create Azure Bastion host resource group
resource "azurerm_resource_group" "bastion" {
  name     = var.resource_group_name
  location = var.location

  # Create Tags 
  tags = var.tags
}