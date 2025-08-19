terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

output "id"           { value = azurerm_container_registry.acr.id }
output "login_server" { value = azurerm_container_registry.acr.login_server }
