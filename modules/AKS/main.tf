# resource "azurerm_kubernetes_cluster" "AKS" {
#   name                = "prod-aks"
#   location            = "France Central"
#   resource_group_name = "prod-rg"
#   dns_prefix          = "exampleaks1"

#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_D2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = {
#     Environment = "Production"
#   }
# }

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.AKS.kube_config[0].client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.AKS.kube_config_raw

#   sensitive = true
# }

# Create AKS clusters dynamically
resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.aks_clusters
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = each.value.node_count
    vm_size    = each.value.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = each.value.environment
  }
}

# Output client certificate for each cluster
output "client_certificate" {
  value = {
    for name, cluster in azurerm_kubernetes_cluster.aks :
    name => cluster.kube_config[0].client_certificate
  }
  sensitive = true
}

# Output raw kubeconfig for each cluster
output "kube_config_raw" {
  value = {
    for name, cluster in azurerm_kubernetes_cluster.aks :
    name => cluster.kube_config_raw
  }
  sensitive = true
}