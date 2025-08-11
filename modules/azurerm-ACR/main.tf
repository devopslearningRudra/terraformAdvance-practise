resource "azurerm_container_registry" "acrs" {
    for_each = var.acr_configs
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    sku = each.value.sku
    admin_enabled = each.value.admin_enabled
  
}