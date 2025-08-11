

resource "azurerm_mssql_server" "sqlserver" {
    for_each = var.mssqlserver289
  name                         =each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  minimum_tls_version          = each.value.minimum_tls_version

  azuread_administrator {
    login_username = each.value.azuread_administrator.login_username
    object_id      = each.value.azuread_administrator.object_id
  }
 tags = each.value.tags

  }
