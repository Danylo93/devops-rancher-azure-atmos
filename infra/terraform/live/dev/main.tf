locals { rg_name = "${var.prefix}-rg" }

module "rg" {
  source   = "../../modules/resource_group"
  name     = local.rg_name
  location = var.location
}


module "net" {
  source   = "../../modules/network"
  prefix   = var.prefix
  location = var.location
  rg_name  = module.rg.name
}

module "acr" {
  source   = "../../modules/acr"
  acr_name = var.acr_name
  rg_name  = module.rg.name
  location = var.location
}


module "aks" {
  source = "${path.module}/../../modules/aks"
  prefix       = var.prefix
  location     = var.location
  rg_name      = module.rg.name
  subnet_id    = module.net.subnet_aks_id
  acr_id       = module.acr.id
  k8s_version  = var.k8s_version
  node_vm_size = var.node_vm_size
  node_count   = var.node_count
}