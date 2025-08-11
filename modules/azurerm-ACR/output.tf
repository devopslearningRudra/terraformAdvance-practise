
output "acr_logins" {
  description = "Login servers of all ACRs"
  value = {
    for acr_name, acr_resource in azurerm_container_registry.acrs :
    acr_name => acr_resource.login_server
  }
}