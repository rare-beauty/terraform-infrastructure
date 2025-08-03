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