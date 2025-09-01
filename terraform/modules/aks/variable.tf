variable "aks_name" {
  type = string
}
variable "aks_location" {
  type = string
}
variable "rgname" {
  type = string
}
variable "dns_prefix" {
  type = string
}
variable "private_cluster_enabled" {
  type = bool
  description = "Use private API server endpoints"
  default = true
}
variable "node_count" {
  type = number
}
variable "vm_size" {
  type = string
}
variable "host_encryption_enabled" {
  type = bool
  description = "Encrypt temp disks/caches on nodes"
  default = true
}
variable "environment" {
  type = string
}
variable "vnet_subnet_id" {
  type = string
}

variable "acr_id" {
  type = string
}
