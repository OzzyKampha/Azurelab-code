##########################################################
# Promote VM to be a Domain Controller
##########################################################

module "promote-dc" {
  source  = "..//promote-domain-controller"
  
  # insert the 7 required variables here
  resource_group_name           = "${var.resource_group_name}"
  location                      = "${var.location}"
  virtual_machine_id            = azurerm_windows_virtual_machine.dc.id
  active_directory_domain       = "${var.active_directory_domain}"
  active_directory_netbios_name = "${var.active_directory_netbios_name}"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
}
