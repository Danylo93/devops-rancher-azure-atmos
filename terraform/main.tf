terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.113"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source   = "./modules/resource-group"
  rg_name  = var.rg_name
  location = var.location
}

module "network" {
  source           = "./modules/network"
  rg_name          = module.resource_group.rg_name
  vnet_name        = var.vnet_name
  address_space    = var.address_space
  aks_subnet_name  = var.aks_subnet_name
  aks_subnet_prefix = var.aks_subnet_prefix
}

module "aks" {
  source            = "./modules/aks"
  rg_name           = module.resource_group.rg_name
  cluster_name      = var.cluster_name
  kubernetes_version = var.kubernetes_version
  node_vm_size      = var.node_vm_size
  node_count        = var.node_count
  aks_subnet_id     = module.network.aks_subnet_id
}
