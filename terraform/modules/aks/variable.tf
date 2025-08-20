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
variable "node_count" {
  type = number
}
variable "vm_size" {
  type = string
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
