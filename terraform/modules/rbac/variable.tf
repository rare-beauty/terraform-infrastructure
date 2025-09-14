variable "assignments" {
  description = "List of role assignments"
  type = map(object({
    principal_id    = string
    role_definition = string
    scope           = string
  }))
  default = {}
}

variable "enabled" {
  type    = bool
  default = true
}

