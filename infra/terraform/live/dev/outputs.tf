output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "ingress_public_ip" {
  value = module.net.ingress_public_ip
}

output "acr_login_server" {
  value = module.acr.login_server
}
