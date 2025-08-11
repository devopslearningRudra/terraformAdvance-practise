variable "keyvaults" {
  description = "A map of Keyvaults will be created "
  type = map(object({
    name = string
    location=string
    resource_group_name= string
    tenant_id= string
    sku_name= string
    soft_delete_retention_days =number
    purge_protection_enabled =bool
    access_policy = object({
      tenant_id = string
      object_id = string
      key_permissions = list(string)
      secret_permissions = list(string)
      storage_permissions =list(string)
      certificate_permissions = list(string)
    })
  })) 
}
