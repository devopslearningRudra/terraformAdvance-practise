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