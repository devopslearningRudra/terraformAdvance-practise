resource "azurerm_cosmosdb_account" "cosmos_account" {
  for_each = var.cosmos_accounts
  name =each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  offer_type = each.value.offer_type
  kind = each.value.kind

consistency_policy {
  consistency_level = each.value.consistency_level
}
geo_location {
  location = each.value.location
  failover_priority = 0
}
capabilities {
  name = "EnableAggregationPipeline"
}
# enable_automatic_failover =false
backup{
    type = "Periodic"
    interval_in_minutes = 240
    retention_in_hours = 8
}
lifecycle {
  ignore_changes = [ tags ]
}
}