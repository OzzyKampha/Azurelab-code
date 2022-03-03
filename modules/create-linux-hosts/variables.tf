# Variables 

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

variable "vm_name" {
    type        = list(string)
}

variable "vm_size" {
    description = "Type of VM/Size"
}

variable "admin_username" {
    description = "Admin username"
}

variable "admin_password" {
    description = "Admin password"
}