resource "azurerm_role_assignment" "this" {
  for_each             = var.enabled ? var.assignments : {}
  
  principal_id         = each.value.principal_id
  role_definition_name = each.value.role_definition
  scope                = each.value.scope
}

