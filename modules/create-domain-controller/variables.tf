# Definition of Variables

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

variable "tags" {
    type  = map(string)
    description = "Tags"
    default = {}
} 

variable "vm_size" {
    description = "Type of VM/Size"
}

variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `contoso.local`"
}

variable "active_directory_netbios_name" {
  description = "The netbios name of the Active Directory domain, for example `contoso`"
}

variable "ou_path" {
  description = "An organizational unit (OU) within an Active Directory to place computers"
  default     = null
}

variable "admin_username" {
    description = "Admin username"
}

variable "admin_password" {
    description = "Admin password"
}