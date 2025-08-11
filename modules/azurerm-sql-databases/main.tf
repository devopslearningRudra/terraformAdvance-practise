
data "azurerm_mssql_server" "example" {
  for_each = var.mssqldb2928_demo
  name     =each.value.sqlserver_name
  resource_group_name =each.value.resource_group_name
}

resource "azurerm_mssql_database" "mssqldb" {
for_each = var.mssqldb2928_demo
name = each.value.name
server_id = data.azurerm_mssql_server.example[each.key].id
collation = each.value.collation
license_type = each.value.license_type
max_size_gb = each.value.max_size_gb
sku_name = each.value.sku_name
enclave_type = each.value.enclave_type
tags =each.value.tags

# prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
