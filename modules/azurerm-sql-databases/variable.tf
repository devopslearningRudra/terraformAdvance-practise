variable "mssqldb2928_demo" {

description = "A map of SQLDB will be create"
type = map(object({
  name = string
  resource_group_name =string
  sqlserver_name = string
  collation = string
  license_type =string
  max_size_gb = number
  sku_name =string
  enclave_type = string
lifecycle = object({
   prevent_destroy = bool
 })
 tags = map(string)
}))
  
}