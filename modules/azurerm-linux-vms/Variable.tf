variable "NICS" {
  description = "A map of NIC will Create"
  type = map(object({
    name = string
    location =string
    resource_group_name =string
    ip_configuration= map(string)
    subnet_id = string
    private_ip_address_allocation= string

  }))
}


variable "PIP" {
    description = "A map of PIP will be created "
    type = map(object({
      name = string
      resource_group_name= string
      location = string
      allocation_method =string
    }))
}
variable "linux-vm" {
    description = "A map of linux VM will create "
    type = map(object({
      name = string
      resource_group_name= string
      location =string
      size =string
      disable_password_authentication =bool
      admin_username =string
      admin_password =string
      caching =string
      storage_account_type =string
      publisher =string
      offer =string
      sku =string
      version =string
      nic_key = string
      pip_key = optional(string)
    }))
  
}