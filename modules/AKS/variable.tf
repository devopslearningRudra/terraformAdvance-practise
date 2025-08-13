variable "aks_clusters" {
  description = "Map of AKS cluster definitions"
  type = map(object({
    location       = string
    resource_group = string
    dns_prefix     = string
    node_count     = number
    vm_size        = string
    environment    = string
  }))
}