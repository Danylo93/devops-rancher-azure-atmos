variable "acr_name" {
  description = "Nome do Azure Container Registry (único global)."
  type        = string
}

variable "rg_name" {
  description = "Resource Group do ACR."
  type        = string
}

variable "location" {
  description = "Região do ACR (ex: eastus2)."
  type        = string
}
