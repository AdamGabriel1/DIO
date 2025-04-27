# Módulo de Banco de Dados
variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type = string
}

resource "azurerm_sql_server" "sql" {
  # ... (configuração do servidor SQL)
}

resource "azurerm_sql_database" "sqldb" {
  # ... (configuração do banco de dados SQL)
}

