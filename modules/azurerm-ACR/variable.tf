variable "acr_configs" {
  description = "A map of ACR Will be create"
  type = map(object({
    resource_group_name =string 
    name =string
    location= string
    sku= string
    admin_enabled = bool
  }))
}