resource "azurerm_storage_container" "contains" {
    for_each = var.contains
    name = each.value.name
    storage_account_id = data.azurerm_storage_account.stgs-data[each.key].id

}