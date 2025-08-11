variable "mssqlserver289" {
    description = "A map of mssqlserver will create"
   type = map(object({
     name = string
     resource_group_name=string
     location =string
     administrator_login =string
     administrator_login_password =string
     minimum_tls_version =string
     azuread_administrator = object({
       login_username = string
       object_id =string
     })
     tags =optional (map(string))
   }))
}