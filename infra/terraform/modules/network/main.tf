terraform {
  required_providers { azurerm = { source = "hashicorp/azurerm" } }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_cidr]
}

resource "azurerm_public_ip" "ingress" {
  name                = "${var.prefix}-ingress-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

output "subnet_aks_id" { value = azurerm_subnet.aks.id }
output "ingress_public_ip_id" { value = azurerm_public_ip.ingress.id }
output "ingress_public_ip" { value = azurerm_public_ip.ingress.ip_address }