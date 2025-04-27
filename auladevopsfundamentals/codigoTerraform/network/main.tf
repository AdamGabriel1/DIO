# Módulo de Network
variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type = string
}

resource "azurerm_virtual_network" "vnet" {
  # ... (configuração da rede)
}

