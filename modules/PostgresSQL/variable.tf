variable "postgresql_servers" {
  description = "Map of PostgreSQL server configurations"
  type = map(object({
    location          = string
    resource_group    = string
    administrator_login = string
    administrator_password = string
    sku_name          = string
    version           = string
    storage_mb        = number
  }))
}