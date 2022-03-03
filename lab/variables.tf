# Variables for Resources


# General information
variable "location" {
  type        = string
  description = "Location of Azure Data Center"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "file_path" {
  type        = string
  description = "Location of files"
}

# Tags
variable "tags" {
    type  = map(string)
    description = "Tags"
    default = {}
}  
  
variable "dns_servers" {}


# VM Size
variable "vm_size1" {
    description = "Type of VM/Size"
}

variable "vm_size2" {
    description = "Type of VM/Size"
}

variable "vm_size3" {
    description = "Type of VM/Size"
}

# VM Names
variable "admin_client_name" {
    description = "Name of the Admin host"
}

variable "custom_client_name" {
    description = "Additional client name"
}

variable "elastic_vm_name" {}

variable "linux_vm_name" {
    type       = list(string)
}

variable "windows_vm_name" {
    type        = list(string)
}

# User Credentials
variable "admin_username" {
    description = "Admin username"
}

variable "admin_password" {
    description = "Admin password"
}

# Active Directory Domain
variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `consoto.local`"
}

variable "active_directory_netbios_name" {
  description = "The netbios name of the Active Directory domain, for example `consoto`"
}





