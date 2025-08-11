variable "mysqldatabase" {
  description = "Map of MYSQL database will create"
  type = map(object({
    name = string
    charset = optional(string,"utf8")
    collation =optional(string,"utf8_unicode_ci")
    server_name =string
    resource_group_name =string
  }))
}