variable "prefix"     { type = string }
variable "location"   { type = string }
variable "rg_name"    { type = string }
variable "subnet_id"  { type = string }
variable "acr_id"     { type = string }
variable "k8s_version"{
  type        = string
  default     = null
  description = "ex.: 1.29.x; null usa padrão"
}
# NÃO precisamos de node_vm_size/node_count agora porque estão FORÇADOS
