data "azurerm_subnet" "bas-sub"{
for_each = {
    for key, value in var.bastions:key => value if value.sku !="Developer"
}
name ="AzureBastionSubnet"
virtual_network_name = each.value.virtual_network_name
resource_group_name = each.value.resource_group_name

}

# Line-by-line Explanation in Hindi:
# 🔹 data "azurerm_subnet" "bas-sub"
# यह Terraform को बता रहा है कि हम Azure में पहले से मौजूद एक subnet की जानकारी लेंगे।

# "bas-sub" एक नाम है जिससे हम इस data block को बाद में refer करेंगे।
# 🔹 for_each = { ... }
# हम यह block multiple बार चलाना चाहते हैं — हर ऐसे bastion के लिए जिसकी sku "Developer" नहीं है।
# इसीलिए हम for_each का उपयोग कर रहे हैं।

# 🔹 अंदर का for loop:
# for key, value in var.bastions : key => value if value.sku != "Developer"
# var.bastions एक variable है जिसमें bastion की details होंगी (map format में)।

# हम loop चला रहे हैं हर bastion पर (key = नाम, value = उसकी details)।

# और सिर्फ उन्हीं पर चला रहे हैं जिनकी sku != "Developer" है।

# 📌 मतलब: हम उन bastions के लिए subnet data निकालेंगे जिनकी SKU "Developer" नहीं है।

# 🔹 name = "AzureBastionSubnet"
# यह Azure में मौजूद subnet का नाम है, जो हर bastion VNet के अंदर होना चाहिए। Azure Bastion के लिए ये subnet name फिक्स होता है — "AzureBastionSubnet"।

# 🔹 virtual_network_name = each.value.virtual_network_name
# हम उस subnet को खोजेंगे जो किस VNet में है? यह VNet का नाम each.value (bastion info) से लिया जाएगा।

# 🔹 resource_group_name = each.value.resource_group_name
# वह VNet किस resource group में है, यह भी हमें bastion की details से मिलेगा।

data"azurerm_virtual_network" "bas-vnet"{
    for_each = {for vnet ,vnet_details in var.bastions:vnet => vnet_details if vnet_details.virtual_network_id ==true
 }
 name = each.value.virtual_network_name
 resource_group_name = each.value.resource_group_name

}

#  data "azurerm_virtual_network" "bas-vnet"
# यह block Azure में पहले से मौजूद एक Virtual Network (VNet) की जानकारी लाने के लिए है।

# "bas-vnet" नाम से हम बाद में इसे refer कर सकते हैं।

# 🔹 for_each = { ... }
# हम ये block सिर्फ उनके लिए चलाना चाहते हैं जिनकी bastion config में virtual_network_id == true है।

# 🔹 अंदर का for loop:
# for vnet, vnet_details in var.bastions : vnet => vnet_details if vnet_details.virtual_network_id == true
# var.bastions में से हम हर bastion (vnet) पर loop चला रहे हैं।
# हम केवल उन्हीं को चुन रहे हैं जिनकी detail में virtual_network_id = true सेट है। इसका मतलब है कि वह bastion किसी existing virtual network से जुड़ा है, जिसकी जानकारी हमें चाहिए।

# 🔹 name = each.value.virtual_network_name
# जिस VNet को हम Azure से fetch करना चाहते हैं, उसका नाम यहाँ दिया जा रहा है।

# 🔹 resource_group_name = each.value.resource_group_name
# उस VNet का resource group यहाँ दिया गया है, जिससे Azure में वह VNet uniquely identify किया जा सके।

# 🔚 कुल मिलाकर क्या हो रहा है?
# Block	काम	किन पर लागू हो रहा है
# bas-sub	Azure Bastion के लिए subnet की जानकारी ला रहा है	सिर्फ जिनका sku != "Developer"
# bas-vnet	Existing Virtual Network की जानकारी ला रहा है	सिर्फ जिनका virtual_network_id == true