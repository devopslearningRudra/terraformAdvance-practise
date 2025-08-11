data "azurerm_storage_account" "stgs-data" {
    for_each = var.contains
  name = each.value.name
  resource_group_name = each.value.resource_group_name

}