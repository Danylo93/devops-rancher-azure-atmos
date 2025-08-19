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

module "vm" {
  source       = "${path.module}/../../modules/vm"
  prefix       = var.prefix
  location     = var.location
  rg_name      = module.rg.name
  subnet_id    = module.net.subnet_id
  public_ip_id = module.net.public_ip_id
  public_ip    = module.net.public_ip
  admin_username = var.admin_username
  admin_ssh_key  = var.admin_ssh_key
  vm_size        = var.vm_size
}