# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.93"
    }
  }
}
provider "azurerm" {
  features {}
}

# Create a resource group for Azure Iamges
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  # Create Tags 
  tags = var.tags
}
