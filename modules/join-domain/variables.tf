# Definition of Variables

variable "vm_name" {}
variable "virtual_machine_id" {}

# Active Directory variables
variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `contoso.local`"
}

variable "admin_username" {
    description = "Admin username"
}

variable "admin_password" {
    description = "Admin password"
}