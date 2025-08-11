# resource "azurerm_network_security_group" "nsg" {
# for_each = var.NSGs
# name = each.value.name
# location = each.value.location
# resource_group_name = each.value.resource_group_name

# security_rule {
#     name                       = each.value.name
#     priority                   = each.value.priority
#     direction                  = each.value.direction
#     access                     = each.value.access
#     protocol                   = each.value.protocol
#     source_port_range          = each.value.source_port_range
#     source_address_prefix      = each.value.source_address_prefix 
#     destination_port_range     = each.value.destination_port_range
#     destination_address_prefix = each.value.destination_address_prefix
#   }
# }
# }

# Using Dynamic Block

resource "azurerm_network_security_group" "nsg" {
    for_each = var.NSGs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

 dynamic "security_rule" {
    for_each = each.value.security_rules != null ? each.value.security_rules : {}
#👉
#  Eska matlab hota hai:

# Agar each.value.security_rules null nahi hai, toh usi ko use karo.

# Agar woh null hai, toh khaali map {} use karo.

# 👉 Terraform mein for_each = {} allowed hota hai. Bas null allowed nahi hota.

# Is tarah se aapka code kabhi fail nahi karega — agar security_rules diya hai toh rules create honge, warna skip ho jaayega silently.

   content {
    name                       = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   =security_rule.value.protocol
    source_port_range         =security_rule.value.source_port_range
    destination_port_range    = security_rule.value.destination_port_range
    source_address_prefix      = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
  
}

