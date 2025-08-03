resource "azurerm_kubernetes_cluster" "my_aks" {
  name                = var.aks_name
  location            = var.aks_location
  resource_group_name = var.rgname
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }
}