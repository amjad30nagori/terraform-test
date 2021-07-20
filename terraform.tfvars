# Common

resource_group  = "anagori-rg"
location        = "centralus"
resource_prefix = "amjt"

# Network

vnetaddress = "10.0.0.0/21"

subnets = {
  Subnet1 = "10.0.0.0/24"
}

# Load balancer

domain_name_label = "anagoripresidiotest245"

# Key Vault

keyvault   = "test-keyvault-245"
secretname = "vmpassword"

# Virtual Machine Variables
vm_count            = 3
fault_domain_count  = 3
update_domain_count = 3
vm_size             = "Standard_B1s"
vm_username         = "useraccount1"
vm_os_disk_type     = "Standard_LRS"

# Alert Email

alert_email = "amjad30nagori@gmail.com"