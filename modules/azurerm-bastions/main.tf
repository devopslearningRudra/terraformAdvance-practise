
resource "azurerm_public_ip" "bastion-pips" {
 for_each = {
    for key, value in var.bastions : key => value if value.sku != "Developer"
    
  }
     name = "${each.value.name}-pip"
     location = each.value.location
     resource_group_name = each.value.resource_group_name
     allocation_method = each.value.allocation_method
     sku = each.value.pip_sku
}
# 🧠 आसान भाषा में समझिए:
# 🔹 resource "azurerm_public_ip" "bastion-pips"
# Ye ek Azure Public IP address resource define kar raha hai.

# "bastions-pips" iska naam hai, jiska use module ke andar reference ke liye hota hai.

# 🔹 for_each = { ... }
# for_each ka use yahan multiple public IPs banane ke liye ho raha hai, jo var.bastions variable se aa rahe hain.

# Ye variable ek map ya object hoga jisme bastion host configurations hain.

# 🔹 for key, value in var.bastions : key => value if value.sku != "Developer"
# Is loop ka matlab hai: bastion list me se sirf unhi items ko choose karo jin ka SKU "Developer" nahi hai.

# key => value format me ek naya map banaya ja raha hai, jise for_each me pass kiya ja raha hai.

# 👉 Matlab: Agar kisi bastion ka sku = "Developer" hai to uske liye public IP nahi banega.

# 🔹 name = "${each.value.name}-pip"
# Har public IP ka naam banaya ja raha hai: bastion ka naam + -pip suffix.

# 🔹 location = each.value.location
# Public IP wahi location me banega jahan bastion host hai.

# 🔹 resource_group_name = each.value.resource_group_name
# Ye resource kis Resource Group me create hoga — wo value bastion ke config se li ja rahi hai.

# 🔹 allocation_method = each.value.allocation_method
# IP address ka allocation method (e.g., Static ya Dynamic).

# 🔹 sku = each.value.pip_sku
# IP ka SKU define karta hai (Basic ya Standard).

# 🔚 अंत में:
# Ye Terraform block bastion hosts ke liye public IPs banata hai, lekin sirf unhi bastions ke liye jinke SKU "Developer" nahi hain.


resource "azurerm_bastion_host" "bastions" {
   for_each = var.bastions
   name = each.value.name
   location = each.value.location
   resource_group_name = each.value.resource_group_name
   virtual_network_id = lookup(each.value,"sku",null) == "Developer"? data.azurerm_virtual_network.bas-vnet[each.key].id : null
   shareable_link_enabled = each.value.shareable_link_enabled
   kerberos_enabled = each.value.kerberos_enabled
   ip_connect_enabled = each.value.ip_connect_enabled
   sku = each.value.sku
   copy_paste_enabled = each.value.copy_paste_enabled
   file_copy_enabled = each.value.file_copy_enabled
   tags = each.value.tags
   zones = each.value.zones
   tunneling_enabled = each.value.tunneling_enabled
   session_recording_enabled = each.value.session_recording_enabled

   dynamic "ip_configuration" {
      for_each = lookup(each.value,"sku", null) == "Developer" ? [] :[1] # # Empty list for "Developer", non-empty for others
     content {
       name = "${each.value.name}-ip-config"
       subnet_id = data.azurerm_subnet.bas-sub[each.key].id
       public_ip_address_id = azurerm_public_ip.bastion-pips[each.key].id
     }
   }
  
}

# dynamic "ip_configuration" {
#   for_each = lookup(each.value,"sku", null) == "Developer" ? [] : [1]  # Empty list for "Developer", non-empty for others
# 🔹 Line 1: dynamic "ip_configuration"
# Terraform में dynamic block तब उपयोग होता है जब हमें किसी block (जैसे ip_configuration) को condition के आधार पर include/exclude करना हो।

# यहाँ हम ip_configuration block को dynamic बना रहे हैं।
# 🔹 Line 2: for_each = lookup(each.value,"sku", null) == "Developer" ? [] : [1]
# यह line बहुत important है — चलिए इसे तोड़कर समझते हैं:

# lookup(each.value,"sku", null) →
# यह bastion की details से "sku" नाम की key की value खोजता है। अगर ना मिले तो null return करता है।

# == "Developer" →
# यह चेक करता है कि उस bastion की SKU "Developer" है या नहीं।

# ? [] : [1] →
# यह एक ternary condition है:
# Condition	for_each को क्या मिलेगा	मतलब
# अगर "sku" == "Developer"	खाली लिस्ट []	मतलब block apply नहीं होगा
# अगर "sku" != "Developer"	एक आइटम वाली लिस्ट [1]	block apply होगा
# 📌 तो यह logic ensure करता है कि ip_configuration block सिर्फ तभी apply हो जब bastion "Developer" नहीं है।
# content {
#     name = "${each.value.name}-ip-config"
#     🔹 content { ... }
# जब dynamic block apply होगा, तो यही content उसमें डाला जाएगा।
# मतलब actual ip_configuration block की अंदर की values यहीं define हैं।
# 🔹 name = "${each.value.name}-ip-config"
# Bastion का नाम लिया जा रहा है और उसके साथ -ip-config जोड़ा जा रहा है।
# उदाहरण: अगर bastion का नाम "bastion1" है, तो config name होगा "bastion1-ip-config"।
# subnet_id = data.azurerm_subnet.bas-sub[each.key].id
#  🔹 subnet_id
# Bastion किस subnet में deploy होगा, उसका ID दिया जा रहा है।
# यह ID हम पहले वाले data "azurerm_subnet" "bas-sub" block से ला रहे हैं।
# each.key के ज़रिए हम specific bastion को identify कर रहे हैं।
# public_ip_address_id = azurerm_public_ip.bastion-pips[each.key].id
# 🔹 public_ip_address_id
# Bastion के लिए जो public IP allocate किया गया है, उसका ID दिया जा रहा है।
# यह IP Terraform के resource azurerm_public_ip.bastion-pips से आया है।

