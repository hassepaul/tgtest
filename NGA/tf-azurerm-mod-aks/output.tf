output "azurerm_kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.cluster.id
}

output "azurerm_kubernetes_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.cluster.fqdn
}

output "azurerm_kubernetes_cluster_private_fqdn" {
  value = azurerm_kubernetes_cluster.cluster.private_fqdn
}

output "azurerm_kubernetes_cluster_kube_admin_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_admin_config
}

output "azurerm_kubernetes_cluster_kube_admin_config_raw" {
  value = azurerm_kubernetes_cluster.cluster.kube_admin_config_raw
}

output "azurerm_kubernetes_cluster_kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config
}

output "azurerm_kubernetes_cluster_kube_config_raw" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "azurerm_kubernetes_cluster_node_resource_group" {
  value = azurerm_kubernetes_cluster.cluster.node_resource_group
}

output "azurerm_kubernetes_cluster_kubelet_identity" {
  value = azurerm_kubernetes_cluster.cluster.kubelet_identity
}
