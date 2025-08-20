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
network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = "10.2.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.2.0.0/24"
    subnet_id          = var.vnet_subnet_id
  }

  tags = {
    Environment = var.environment
  }
}
