variable "location" {
  type    = string
  default = "westeurope"
}

variable "tags" {
  type    = map
  default = {
    "Ambiente"   = "Desenvolvimento"
    "Integracao" = "Processo DevOps"
    "Compania"   = "Aula DevOps"
    "Area"       = "Marketing"
  }
}

