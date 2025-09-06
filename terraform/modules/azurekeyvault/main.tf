resource "azurerm_key_vault" "my_kv" {
  name                       = var.kv_name
  location                   = var.location
  resource_group_name        = var.rg_name
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  enable_rbac_authorization     = var.enable_rbac_authorization
  public_network_access_enabled = var.public_network_access_enabled
  tags = var.tags

  network_acls {
    default_action = var.kv_network_default_action   # "Deny"
    bypass         = var.kv_bypass                   # "AzureServices"
    ip_rules                   = var.kv_ip_rules
    virtual_network_subnet_ids = var.kv_vnet_subnet_ids
  }

}


