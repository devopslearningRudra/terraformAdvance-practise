
# data "azurerm_subnet" "subnets" {
#   name                 = "Hub-subnet"
#   virtual_network_name = "Prod-hub-Vnet"
#   resource_group_name  = "prod-rg"
# }

# output "subnet_id" {
#   value = data.azurerm_subnet.subnets.id
# }


resource "azurerm_network_interface" "nics" {
  for_each = var.NICS
  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
 ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}
