resource "azurerm_virtual_machine_extension" "join-domain" {
  name                 = "${var.vm_name}"
  virtual_machine_id   = "${var.virtual_machine_id}"
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "Name": "${var.active_directory_domain}",
        "User": "${var.admin_username}@${var.active_directory_domain}",
        "OUPath": "",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "Password": "${var.admin_password}"
    }
PROTECTED_SETTINGS

}