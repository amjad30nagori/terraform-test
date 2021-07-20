# Virtual Machines

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.resource_prefix}-vm-${var.index}-nic"
  resource_group_name = var.resource_group
  location            = var.location

  ip_configuration {
    name                          = "${var.resource_prefix}-vm-${var.index}-nic-configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_association" {
  network_interface_id    = azurerm_network_interface.vm_nic.id
  ip_configuration_name   = "${var.resource_prefix}-vm-${var.index}-nic-configuration"
  backend_address_pool_id = var.load_balancer_id
}

resource "azurerm_virtual_machine" "virtual_machine" {
  name                  = "${var.resource_prefix}-vm-${var.index}"
  resource_group_name   = var.resource_group
  location              = var.location
  availability_set_id   = var.availability_set_id
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-smalldisk"
    version   = "latest"

  }
  storage_os_disk {
    name              = "${var.resource_prefix}-vm-${var.index}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vm_os_disk_type
  }
  os_profile {
    computer_name  = "${var.resource_prefix}-vm-${var.index}-os"
    admin_username = var.vm_username
    admin_password = var.vm_password
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_machine_extension" "vm_extension_install_iis" {
  name                       = "${azurerm_virtual_machine.virtual_machine.name}-iis"
  virtual_machine_id         = azurerm_virtual_machine.virtual_machine.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
SETTINGS
}