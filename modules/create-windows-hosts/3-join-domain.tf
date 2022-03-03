# Join AD

module "join-domain" {
  source  = "..//join-domain"
  for_each                      = toset(var.windows_vm_name)
  
  # insert the 5 required variables here
  vm_name                       = "${each.value}"
  virtual_machine_id            = azurerm_windows_virtual_machine.vm[each.value].id
  active_directory_domain       = "${var.active_directory_domain}"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
}