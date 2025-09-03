variable "subnet_name" {
  type = string
}
variable "rgname" {
  type = string
}
variable "vnetname" {
  type = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes of the subnet"
  type        = list(string)
}

variable "create_nsg" {
  type    = bool
  default = true
}

variable "nsg_name" {
  type    = string
  default = null
}

variable "location" {
  type = string
}

# Optional: tweak/extend rules as needed
variable "nsg_rules" {
  description = "List of NSG security rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    # Allow intra-VNet traffic
    {
      name                       = "allow-virtual-network"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
    # Allow Azure Load Balancer probes
    {
      name                       = "allow-azure-loadbalancer"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    }
  ]
}
