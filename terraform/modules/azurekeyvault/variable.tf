variable "kv_name"  { type = string }
variable "location" { type = string }
variable "rg_name"  { type = string }
variable "tenant_id" { type = string }

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "purge_protection_enabled" {
  type    = bool
  default = true
}

variable "soft_delete_retention_days" {
  type    = number
  default = 7
}

variable "enable_rbac_authorization" {
  type    = bool
  default = true
}

# ⬇️ new: wire this into the resource in main.tf
variable "public_network_access_enabled" {
  type    = bool
  # Recommend default = true so dev still works without PE/firewall.
  # Set to false from the calling module or tfvars when you're ready.
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "kv_network_default_action" {
  description = "Default action for KV firewall"
  type        = string
  default     = "Deny"
}

variable "kv_bypass" {
  description = "Bypass for KV firewall"
  type        = string
  default     = "AzureServices"
}

variable "kv_ip_rules" {
  description = "IP CIDRs allowed to access KV (when public is enabled)"
  type        = list(string)
  default     = []
}

variable "kv_vnet_subnet_ids" {
  description = "Subnet IDs allowed to access KV"
  type        = list(string)
  default     = []
}

