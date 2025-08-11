variable "main-subnets" {
    description = "A map of subnet to be create"
    type = map(object({
      name = string
      address_prefixes =list(string)
      resource_group_name = string
      virtual_network_name = string
    }))
     
}