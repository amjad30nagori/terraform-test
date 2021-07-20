# Availability Set

resource "azurerm_availability_set" "vm_avset" {
  name                         = "${var.resource_prefix}-vm-avset"
  location                     = var.location
  resource_group_name          = var.resource_group
  platform_update_domain_count = var.fault_domain_count
  platform_fault_domain_count  = var.update_domain_count
  lifecycle {
    ignore_changes = [tags]
  }
}