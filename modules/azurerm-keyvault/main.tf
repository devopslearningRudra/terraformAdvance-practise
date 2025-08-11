resource "azurerm_key_vault" "keyvaults27456" {
 for_each = var.keyvaults
name = each.value.name
location = each.value.location
resource_group_name = each.value.resource_group_name
tenant_id = each.value.tenant_id
sku_name = each.value.sku_name
soft_delete_retention_days = each.value.soft_delete_retention_days
purge_protection_enabled = each.value.purge_protection_enabled
access_policy {
    tenant_id = each.value.access_policy.tenant_id
    object_id = each.value.access_policy.object_id
    key_permissions = each.value.access_policy.key_permissions
    secret_permissions =each.value.access_policy.secret_permissions
    storage_permissions = each.value.access_policy.storage_permissions
    certificate_permissions = each.value.access_policy.certificate_permissions

}

}