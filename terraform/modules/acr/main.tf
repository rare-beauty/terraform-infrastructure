# checkov:skip=CKV_AZURE_233: Not using Premium/zone redundancy in dev
# checkov:skip=CKV_AZURE_139: Public access allowed in dev; will move to PE later
resource "azurerm_container_registry" "my_acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled

   retention_policy {                                                
    days   = var.retention_days
    enabled = true
  }

  dynamic "georeplications" {                                       
    for_each = var.georeplication_locations
    content {
      location                = georeplications.value
      zone_redundancy_enabled = true
    }
  }
  tags = var.tags
}
