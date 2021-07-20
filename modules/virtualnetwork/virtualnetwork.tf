resource "azurerm_virtual_network" "virtual_network"{
    name                  =   "${var.resource_prefix}-vnet"
    location              =   var.location
    resource_group_name   =   var.rg_name
    address_space         =   [var.vnet_address_space]
  lifecycle  {
    ignore_changes        =   [tags]
  }
}