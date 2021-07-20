output "vm_private_ip" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_id" {
  value = azurerm_virtual_machine.virtual_machine.id
}

output "vm_name" {
  value = azurerm_virtual_machine.virtual_machine.name
}

