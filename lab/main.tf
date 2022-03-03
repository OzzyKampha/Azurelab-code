# Main Application

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


# Creates a Elastic Stack Server
module "create-elastic" {
    source              = "..\\modules\\create-elastic"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    vm_name             = "${var.elastic_vm_name}"
    vm_size             = "${var.vm_size3}"
    admin_username      = "${var.admin_username}"
    admin_password      = "${var.admin_password}"
    file_path           = "${var.file_path}"
    tags                = "${var.tags}"
}

/*
# Creates a Ubuntu 18.04 LTS host
module "create-linux" {
    source              = "..\\modules\\create-linux-hosts"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    vm_name             = "${var.linux_vm_name}"
    vm_size             = "${var.vm_size2}"
    admin_username      = "${var.admin_username}"
    admin_password      = "${var.admin_password}"
    file_path           = "${var.file_path}"
    tags                = "${var.tags}"
}
*/


# Creates a Windows 10 host connected to the Lab network but NOT DOMAIN Joined
module "create-custom-host1" {
   source               = "..\\modules\\create-custom-host"
   resource_group_name  = "${var.resource_group_name}"
   location             = "${var.location}"
   client_name          = "${var.admin_client_name}"
   vm_size              = "${var.vm_size1}"
   admin_username       = "${var.admin_username}"
   admin_password       = "${var.admin_password}"
   file_path            = "${var.file_path}"
   tags                 = "${var.tags}"

   depends_on       = [module.create-elastic]
}

# Creates a Windows Server 2019 and Promotes it to a Domain controller for contoso.com
module "create-domain-controller" {
   source                         = "..\\modules\\create-domain-controller"
   resource_group_name            = "${var.resource_group_name}"
   location                       = "${var.location}"
   vm_size                        = "${var.vm_size1}"
   admin_username                 = "${var.admin_username}"
   admin_password                 = "${var.admin_password}"
   active_directory_domain        = "${var.active_directory_domain}"
   active_directory_netbios_name  = "${var.active_directory_netbios_name}"
   file_path                      = "${var.file_path}"
   tags                           = "${var.tags}"

  depends_on       = [module.create-custom-host1]
}


# Create two Windows 10 Clients and joins the domain
module "create-windows-hosts" {
    source                        = "..\\modules\\create-windows-hosts"
    windows_vm_name               = "${var.windows_vm_name}"
    resource_group_name           = "${var.resource_group_name}"
    location                      = "${var.location}"
    admin_username                = "${var.admin_username}"
    admin_password                = "${var.admin_password}"
    active_directory_domain       = "${var.active_directory_domain}"
    dns_servers                   = "${var.dns_servers}"
    file_path                     = "${var.file_path}"
    tags                          = "${var.tags}"

  depends_on       = [module.create-domain-controller]
}