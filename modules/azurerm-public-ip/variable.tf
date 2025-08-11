
variable "PIP" {
    description = "A map of PIP will be created "
    type = map(object({
      name = string
      resource_group_name= string
      location = string
      allocation_method =string
    }))
}