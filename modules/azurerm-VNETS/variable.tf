variable "main_vnets" {
  description = "A map of Virtual Network to be crate "
  type = map(object({
    virtual_network_name = string 
    address_space = list(string)
    resource_group_name= string
    virtual_network_location = string
    dns_servers = list(string)
    tags = optional(map(string))
  }))

}