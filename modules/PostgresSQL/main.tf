resource "azurerm_postgresql_flexible_server" "postgresql" {
  for_each = var.postgresql_servers

  name                   = each.key
  location               = each.value.location
  resource_group_name    = each.value.resource_group
  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password
  sku_name               = each.value.sku_name
  version                = each.value.version

  storage_mb = each.value.storage_mb

  zone = "1"  # optional
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  high_availability {
   mode = "ZoneRedundant"
  }
}