# Definition of Variables

variable location {
  type        = string
  description = "Location of Azure Data Center"
}

variable resource_group_name {
  type        = string
  description = "Name of the resource group"
}

variable "file_path" {
  type        = string
  description = "Location of files"
}

variable "tags" {
    type  = map(string)
    description = "Tags"
    default = {}
} 

variable "dns_servers" {}

variable "windows_vm_name" {
    type        = list(string)
}

variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `contoso.local`"
}

variable "admin_username" {
    description = "Admin username"
}

variable "admin_password" {
    description = "Admin password"
}

