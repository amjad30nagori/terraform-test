# Provider information.
provider "azurerm" {
  features {}
}

data "azurerm_key_vault" "key_vault" {
  name                = var.keyvault
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_secret" "vmcreds" {
  name         = var.secretname
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "virtual_network" {
  source             = "./modules/virtualnetwork"
  resource_prefix    = var.resource_prefix
  location           = var.location
  rg_name            = var.resource_group
  vnet_address_space = var.vnetaddress
}

module "subnet" {
  source               = "./modules/subnet"
  snet_name            = each.key
  rg_name              = var.resource_group
  virtual_network_name = module.virtual_network.virtual_network_name
  address_prefixes     = [each.value]
  for_each             = var.subnets
}

# Virutal Machine Deployment

module "loadbalancer" {
  source            = "./modules/loadbalancer"
  resource_prefix   = var.resource_prefix
  resource_group    = var.resource_group
  location          = var.location
  domain_name_label = var.domain_name_label
}

module "availabilityset" {
  source              = "./modules/availabilityset"
  resource_prefix     = var.resource_prefix
  resource_group      = var.resource_group
  location            = var.location
  fault_domain_count  = var.fault_domain_count
  update_domain_count = var.update_domain_count
}

module "vm" {
  source              = "./modules/virtualmachine"
  resource_prefix     = var.resource_prefix
  resource_group      = var.resource_group
  location            = var.location
  subnet_id           = module.subnet["Subnet1"].subnet_id
  vm_size             = var.vm_size
  vm_username         = var.vm_username
  vm_password         = data.azurerm_key_vault_secret.vmcreds.value
  index               = count.index + 1
  count               = var.vm_count
  vm_os_disk_type     = var.vm_os_disk_type
  load_balancer_id    = module.loadbalancer.lb_backend_id
  availability_set_id = module.availabilityset.avsetid
}

# module "vm_alert" {
#   source         = "./modules/monitoralert"
#   alert_name     = "${module.vm[count.index].vm_name}-cpu-alert"
#   resource_group = var.resource_group
#   vm_id          = module.vm[count.index].vm_id
#   email          = var.alert_email
# count               = var.vm_count
# }