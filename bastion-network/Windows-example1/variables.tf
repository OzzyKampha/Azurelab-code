# Definition of Variables

variable "location" {
  type        = string
  description = "Location of Azure Data Center"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "tags" {
    type  = map(string)
    description = "Tags"
    default = {}
} 

variable "admin_username" {
    description = "Admin username"
}

variable "admin_password" {
    description = "Admin password"
}

variable "client_name" {
    description = "Name of the host"
}

variable "vm_size" {
    description = "Type of VM/Size"
}