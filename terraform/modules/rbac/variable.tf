#variable "key_vault_id" {
 # description = "ID of the Key Vault"
 # type        = string
#}

#variable "role_name" {
#  description = "RBAC role name to assign"
#  type        = string
#}

#variable "principal_object_id" {
#  description = "Object ID of the principal (user, service principal, managed identity)"
#  type        = string
#}

variable "assignments" {
  description = "List of role assignments"
  type = list(object({
    principal_id    = string
    role_definition = string
    scope           = string
  }))
  default = []
}

variable "enabled" {
  type    = bool
  default = true
}

