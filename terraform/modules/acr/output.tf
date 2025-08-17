output "acr_id" {
  value = azurerm_container_registry.my_acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.my_acr.login_server
}
