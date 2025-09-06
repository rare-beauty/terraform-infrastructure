resource "azurerm_kubernetes_cluster" "my_aks" {
  name                = var.aks_name
  location            = var.aks_location
  resource_group_name = var.rgname
  dns_prefix          = var.dns_prefix

  sku_tier                 = var.sku_tier                       
  private_cluster_enabled  = var.private_cluster_enabled         
  automatic_channel_upgrade = var.automatic_channel_upgrade      
  local_account_disabled    = var.local_account_disabled         
 # api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges # ✅ CKV_AZURE_6 (public only)

  api_server_access_profile {
    authorized_ip_ranges = var.api_server_authorized_ip_ranges
  }


  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size

    max_pods                     = var.max_pods                  
   # host_encryption_enabled      = var.host_encryption_enabled   
    only_critical_addons_enabled = true                         
    os_disk_type                 = var.os_disk_type              
   # disk_encryption_set_id       = var.disk_encryption_set_id    
    vnet_subnet_id               = var.vnet_subnet_id
  }

  # Logs to Azure Monitor (Log Analytics)
 # oms_agent {                                                   
  #  log_analytics_workspace_id = var.log_analytics_workspace_id
  #}

  # Secrets Store CSI Driver rotation
  key_vault_secrets_provider {                                  
    secret_rotation_enabled = true
  }

  identity { type = "SystemAssigned" }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = "10.2.0.10"
  #  docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.2.0.0/24"
  #  subnet_id          = var.vnet_subnet_id
  }

  addon_profile {
    azure_policy {
      enabled = var.enable_azure_policy
    }
  }

  tags = { Environment = var.environment }
}
