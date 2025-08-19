terraform {
  required_providers { azurerm = { source = "hashicorp/azurerm" } }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "vm" {
  name                 = "snet-vm"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

resource "azurerm_public_ip" "vm" {
  name                = "${var.prefix}-vm-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

output "subnet_id" { value = azurerm_subnet.vm.id }
output "public_ip_id" { value = azurerm_public_ip.vm.id }
output "public_ip" { value = azurerm_public_ip.vm.ip_address }