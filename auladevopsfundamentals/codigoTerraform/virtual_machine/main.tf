# Módulo de Máquina Virtual
variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type = string
}

resource "azurerm_virtual_machine" "vm" {
  # ... (configuração da máquina virtual)
}

