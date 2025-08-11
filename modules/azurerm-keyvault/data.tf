data "azurerm_client_config" "current" {}

# 🔹 Iska matlab:
# Yeh data block current Azure client (jo Terraform command run kar raha hai) ka config nikalta hai — jaise tenant_id aur object_id.
# Ye values hum aage Key Vault ke access policy mein use karenge.