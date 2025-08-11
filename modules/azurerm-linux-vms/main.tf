

resource "azurerm_network_interface" "nics" {
  for_each = var.NICS
  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name = "internal"
    subnet_id = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}


resource "azurerm_public_ip" "pip" {
  for_each = var.PIP
  name = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  allocation_method = each.value.allocation_method

}
resource "azurerm_linux_virtual_machine" "linux-vm" {
  for_each = var.linux-vm
  name = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  size = each.value.size
  disable_password_authentication = false
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password
  network_interface_ids = [ azurerm_network_interface.nics[each.value.nic_key].id,]

os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}