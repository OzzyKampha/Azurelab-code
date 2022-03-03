# Code to deploy a Bastion host with subnet for AzureLab

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


