resource "azurerm_resource_group" "rgs" {
    for_each = var.main_rgs
    name = each.value.name
    location = each.value.location
  
}