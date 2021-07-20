variable "resource_group" {
  type = string
}

variable "resource_prefix" {
  type = string
}

variable "keyvault" {
  type = string
}

variable "secretname" {
  type = string
}

variable "location" {
  type = string
  validation {
    condition     = can(regex("(?i)\\b(eastasia|southeastasia|centralus|eastus|eastus2|westus|northcentralus|southcentralus|northeurope|westeurope|japanwest|japaneast|brazilsouth|australiaeast|australiasoutheast|southindia|centralindia|westindia|canadacentral|canadaeast|uksouth|ukwest|westcentralus|westus2|koreacentral|koreasouth|francecentral|francesouth|australiacentral|australiacentral2|uaecentral|uaenorth|southafricanorth|southafricawest|switzerlandnorth|switzerlandwest|germanynorth|germanywestcentral|norwaywest|norwayeast|brazilsoutheast|westus3)\\b", var.location))
    error_message = "Please provide valid Azure Region in format like 'eastus'."
  }
}

variable "vnetaddress" {
  type = string
  validation {
    condition     = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\/\\b([1-9]|[12][0-9]|3[0-2])\\b$", var.vnetaddress))
    error_message = "Please provide valid IP address range, eg. 10.0.0.0/16."
  }
}

variable "subnets" {
  type = map(any)
}

variable "domain_name_label" {
  type = string
}

variable "fault_domain_count" {
  type = string
}

variable "update_domain_count" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_count" {
  type = number
}

variable "vm_os_disk_type" {
  type = string
  validation {
    condition     = can(regex("(?i)\\b(Standard_LRS|StandardSSD_LRS|Premium_LRS)\\b", var.vm_os_disk_type))
    error_message = "Please provide valid value for environment from 'Standard_LRS', 'StandardSSD_LRS' or 'Premium_LRS'."
  }
}

variable "vm_username" {
  type = string
}

variable "alert_email" {
  type = string
}