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

# 🔒 Networking hardening
variable "public_network_access_enabled" {
  type    = bool
  default = false   # disable public access by default
}

variable "kv_ip_rules" {
  description = "List of public IPs to allow (optional)"
  type        = list(string)
  default     = []
}

variable "kv_vnet_subnet_ids" {
  description = "List of subnet IDs to allow (optional)"
  type        = list(string)
  default     = []
}

# 🔒 Private Endpoint options
variable "enable_private_endpoint" {
  type    = bool
  default = true
}

variable "subnet_id" {
  description = "Subnet for the Private Endpoint NIC (required if PE enabled)"
  type        = string
  default     = null
}

variable "create_dns_zone" {
  description = "Create private DNS zone for Key Vault"
  type        = bool
  default     = true
}

variable "vnet_id" {
  description = "VNet to link DNS zone to (needed if create_dns_zone = true)"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
