variable "mysqlserver1" {
   description  = "mySQL Server need to create "
    type = map(object({
      name = string
      location =string
      resource_group_name =string
      administrator_login =string
      administrator_password =string
      sku_name =string
      version =string
      backup_retention_days =number
    }))

}