# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.my_aks.kube_config[0].client_certificate
#   sensitive = true
# }

output "kube_config" {
  value = azurerm_kubernetes_cluster.my_aks.kube_config_raw
  sensitive = true
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.my_aks.id
  sensitive = true
}

output "kubelet_identity" {
  description = "Object ID of the AKS Kubelet identity"
  value       = azurerm_kubernetes_cluster.my_aks.kubelet_identity[0].object_id
}
