variable "acr_name" {
  description = "Nome do Azure Container Registry (único global, min 5 e max 50)."
  type        = string
}

variable "rg_name" {
  description = "Resource Group onde o ACR será criado."
  type        = string
}

variable "location" {
  description = "Região da Azure (ex: eastus2)."
  type        = string
}
