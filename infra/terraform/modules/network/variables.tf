variable "prefix" {
  description = "Prefixo padrão para nomear recursos de rede."
  type        = string
}

variable "location" {
  description = "Região da Azure (ex.: eastus2)."
  type        = string
}

variable "rg_name" {
  description = "Nome do Resource Group onde a rede será criada."
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR da VNet."
  type        = string
  default     = "10.20.0.0/16"
}

variable "aks_cidr" {
  description = "CIDR da Subnet dedicada ao AKS."
  type        = string
  default     = "10.20.1.0/24"
}
