variable "prefix" {
  description = "Prefixo para os recursos."
  type        = string
}

variable "location" {
  description = "Região da Azure (ex: eastus2)."
  type        = string
}

variable "vm_size" {
  description = "SKU da VM."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Usuário administrador da VM."
  type        = string
}

variable "admin_ssh_key" {
  description = "Chave pública SSH para acesso."
  type        = string
}
