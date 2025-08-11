resource "azurerm_mysql_flexible_server" "mysqlserver1" {
    for_each = var.mysqlserver1
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    administrator_login = each.value.administrator_login
    administrator_password = each.value.administrator_password
    sku_name = each.value.sku_name
    version = each.value.version
    backup_retention_days = each.value.backup_retention_days
  
}