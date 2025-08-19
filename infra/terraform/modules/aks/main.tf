resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.prefix}-aks"

  kubernetes_version = var.k8s_version

default_node_pool {
  name                 = "system"
  vm_size              = "Standard_B2s"   # <-- FORÇADO
  node_count           = 1                # <-- FORÇADO
  vnet_subnet_id       = var.subnet_id
  orchestrator_version = var.k8s_version

  upgrade_settings {
  max_surge = "1"   # use SÓ max_surge aqui
}

}



# Concede AcrPull ao kubelet identity do AKS
resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

