# checkov:skip=CKV_AZURE_233: Not using Premium/zone redundancy in dev
# checkov:skip=CKV_AZURE_139: Public access allowed in dev; will move to PE later
# modules/acr/main.tf
resource "azurerm_container_registry" "my_acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  public_network_access_enabled = var.public_network_access_enabled

  # 👇 Only set on Premium; otherwise omit (null)
  zone_redundancy_enabled = var.sku == "Premium" ? var.zone_redundancy_enabled : null
  data_endpoint_enabled   = var.sku == "Premium" ? var.data_endpoint_enabled   : null

  # ✅ Only add retention when Premium
  dynamic "retention_policy" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      enabled = true
      days    = var.retention_days
    }
  }

  # ✅ Only add geo-replication when Premium
  dynamic "georeplications" {
    for_each = var.sku == "Premium" ? var.georeplication_locations : []
    content {
      location                = georeplications.value
      zone_redundancy_enabled = true
    }
  }

  tags = var.tags
}
