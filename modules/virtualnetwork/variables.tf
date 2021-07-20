variable "resource_prefix"{
    type=string
}

variable "location"{
    type=string
}

variable "rg_name"{
    type=string
}

variable "vnet_address_space"{
    type=string
validation {
    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\/\\b([1-9]|[12][0-9]|3[0-2])\\b$",var.vnet_address_space))
    error_message = "Provide valid IP address range."
}
}
