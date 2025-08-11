resource "azurerm_mysql_flexible_database" "mysqldatabase25" {
  for_each = var.mysqldatabase
  name =each.value.name
  resource_group_name = each.value.resource_group_name
  server_name = each.value.server_name
  charset = lookup(each.value, "charset","utf8")
  collation = lookup(each.value,"collation","utf8_general_ci" )
}