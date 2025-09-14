output "role_assignment_ids" {
  description = "Map of role assignment IDs keyed by your assignment keys."
  value       = { for k, r in azurerm_role_assignment.this : k => r.id }
}
