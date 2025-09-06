#resource "azurerm_role_assignment" "kv_access" {
#  scope                = var.key_vault_id
#  role_definition_name = var.role_name
#  principal_id         = var.principal_object_id
#}

#resource "azurerm_role_assignment" "this" {
 # for_each             = { for idx, a in var.assignments : idx => a }
 # principal_id         = each.value.principal_id
 # role_definition_name = each.value.role_definition
 # scope                = each.value.scope
#}

resource "azurerm_role_assignment" "this" {
  count                = var.enabled ? length(var.assignments) : 0
  principal_id         = var.assignments[count.index].principal_id
  role_definition_name = var.assignments[count.index].role_definition
  scope                = var.assignments[count.index].scope
}

