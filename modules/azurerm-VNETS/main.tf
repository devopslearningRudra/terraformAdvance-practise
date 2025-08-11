

resource "azurerm_virtual_network" "Vnets" {
  for_each = var.main_vnets
  name = each.value.virtual_network_name
  location = each.value.virtual_network_location
 resource_group_name = each.value.resource_group_name
 address_space = each.value.address_space
 dns_servers = each.value.dns_servers

#  dynamic "subnet" {
#    for_each = each.value.subnets
#  content{
#    name = subnet.value.subnets
#    address_prefixes = subnet.value.address_prefixes
#  }
#  }
}