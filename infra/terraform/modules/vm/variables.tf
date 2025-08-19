variable "prefix" {
  description = "Prefixo para nomear a VM."
  type        = string
}

variable "location" {
  description = "Região da Azure."
  type        = string
}

variable "rg_name" {
  description = "Resource Group onde a VM será criada."
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet para a VM."
  type        = string
}

variable "public_ip_id" {
  description = "ID do Public IP associado."
  type        = string
}

variable "public_ip" {
  description = "Endereço IP público da VM."
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
