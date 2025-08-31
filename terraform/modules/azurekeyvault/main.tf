resource "azurerm_key_vault" "my_kv" {
  name                       = var.kv_name
  location                   = var.location
  resource_group_name        = var.rg_name
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  enable_rbac_authorization     = var.enable_rbac_authorization

  # ✅ CKV_AZURE_189: disable public access
  public_network_access_enabled = var.public_network_access_enabled

  # ✅ CKV_AZURE_109: firewall rules block (default deny)
  network_acls {
    default_action               = "Deny"
    bypass                       = "AzureServices"
    ip_rules                     = var.kv_ip_rules
    virtual_network_subnet_ids   = var.kv_vnet_subnet_ids
  }

  tags = var.tags
}

# ✅ CKV2_AZURE_32: Private Endpoint (optional)
locals {
  kv_pe_enabled = var.enable_private_endpoint && var.subnet_id != null
}

resource "azurerm_private_endpoint" "kv_pe" {
  count               = local.kv_pe_enabled ? 1 : 0
  name                = "${azurerm_key_vault.my_kv.name}-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_key_vault.my_kv.name}-pe-conn"
    private_connection_resource_id = azurerm_key_vault.my_kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  tags = var.tags
}

# Private DNS (optional – create only if asked)
resource "azurerm_private_dns_zone" "kv_zone" {
  count               = (local.kv_pe_enabled && var.create_dns_zone) ? 1 : 0
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_zone_link" {
  count                 = (local.kv_pe_enabled && var.create_dns_zone && var.vnet_id != null) ? 1 : 0
  name                  = "${azurerm_key_vault.my_kv.name}-vnetlink"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.kv_zone[0].name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}

resource "azurerm_private_dns_a_record" "kv_pe_record" {
  count               = (local.kv_pe_enabled && var.create_dns_zone) ? 1 : 0
  name                = azurerm_key_vault.my_kv.name
  zone_name           = azurerm_private_dns_zone.kv_zone[0].name
  resource_group_name = var.rg_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.kv_pe[0].private_service_connection[0].private_ip_address]
}
