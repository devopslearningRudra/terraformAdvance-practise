variable "cosmos_accounts" {
  type = map(object({
    name = string
    location =string
    resource_group_name =string
    offer_type =string
    kind =string
    consistency_level=string
  }))
}