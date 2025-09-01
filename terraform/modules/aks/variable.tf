# Core
variable "aks_name"     { 
type = string
}
variable "aks_location" { 
type = string 
}
variable "rgname"       { 
type = string
}
variable "dns_prefix"   { 
type = string 
}
variable "environment"  { 
type = string 
}

# Networking
variable "vnet_subnet_id" {
  type        = string
  description = "Subnet resource ID for AKS nodes"
}

# Optional ACR wiring (if you use it elsewhere)
variable "acr_id" {
  type        = string
  description = "ACR resource ID (optional)"
  default     = null
}

# Cost-friendly cluster settings
variable "sku_tier" {
  type        = string
  description = "AKS control-plane tier: Free (no paid SLA) or Standard (paid)"
  default     = "Free"
  validation {
    condition     = contains(["Free","Standard"], var.sku_tier)
    error_message = "sku_tier must be 'Free' or 'Standard'."
  }
}

# Keep API public by default (private cluster adds Private Link costs).
variable "private_cluster_enabled" {
  type        = bool
  description = "Use private API (adds Private Link cost). Keep false for student/free."
  default     = false
}

# Node pool size/capacity (cheap & small by default)
variable "node_count" {
  type        = number
  description = "Number of nodes"
  default     = 1
}

variable "vm_size" {
  type        = string
  description = "VM size for nodes (cheap option for learning)"
  default     = "Standard_B2s"
}

# Security (no extra cost)
variable "host_encryption_enabled" {
  type        = bool
  description = "Encrypt temp disks/caches on nodes"
  default     = true
}

variable "local_account_disabled" {
  type        = bool
  description = "Disable legacy local admin account"
  default     = true
}

variable "max_pods" {
  type        = number
  description = "Max pods per node (50 satisfies policy, no cost impact)"
  default     = 50
}

# Disk options
variable "os_disk_type" {
  type        = string
  description = "OS disk type: use 'Managed' for widest compatibility on small/B-series"
  default     = "Managed"
  validation {
    condition     = contains(["Ephemeral","Managed"], var.os_disk_type)
    error_message = "os_disk_type must be 'Ephemeral' or 'Managed'."
  }
}

variable "disk_encryption_set_id" {
  type        = string
  description = "Optional Disk Encryption Set (CMK). Leave null on student/free."
  default     = null
}

# Upgrades & API access
variable "automatic_channel_upgrade" {
  type        = string
  description = "Auto-upgrade channel: none, patch, node-image, stable, rapid"
  default     = "patch"
  validation {
    condition     = contains(["none","patch","node-image","stable","rapid"], var.automatic_channel_upgrade)
    error_message = "automatic_channel_upgrade must be one of 'none','patch','node-image','stable','rapid'."
  }
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "Allowed CIDRs for public API. Leave [] for fully public (dev only)."
  default     = []
}

# Logging (Azure Monitor/Log Analytics costs $, so keep optional)
variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID. Leave null to skip (saves cost)."
  default     = null
}

