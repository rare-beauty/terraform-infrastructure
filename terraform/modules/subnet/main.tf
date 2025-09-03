resource "azurerm_subnet" "my_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = var.subnet_address_prefixes
}

# NSG (optional)
resource "azurerm_network_security_group" "this" {
  count               = var.create_nsg ? 1 : 0
  name                = coalesce(var.nsg_name, "${var.subnet_name}-nsg")
  location            = var.location
  resource_group_name = var.rgname

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Associate NSG to subnet
resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = var.create_nsg ? 1 : 0
  subnet_id                 = azurerm_subnet.my_subnet.id
  network_security_group_id = azurerm_network_security_group.this[0].id
}

